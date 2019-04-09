`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/04/2019 10:16:01 AM
// Design Name: 
// Module Name: my_bram_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module my_bram_tb (
    );
    reg BRAM_CLK;
    parameter BRAM_ADDR_WIDTH = 15;
    reg [BRAM_ADDR_WIDTH-1:0] BRAM_ADDR;
    wire [31:0] BRAM_RDDATA;
    wire [31:0] BRAM_RDDATA2;
    reg rBRAM_EN;
    reg wBRAM_EN;
    reg BRAM_RST;
    reg [3:0] BRAM_WE;
    reg done;
    
//    input wire [BRAM_ADDR_WIDTH-1:0] BRAM_ADDR,
//    input wire BRAM_CLK,
//    input wire [31:0] BRAM_WRDATA,
//    output reg [31:0] BRAM_RDDATA,
//    input wire BRAM_EN,
//    input wire BRAM_RST,
//    input wire [3:0] BRAM_WE,
//    input wire done
//);
    integer i;
    initial begin
        BRAM_CLK <= 0;
        rBRAM_EN <= 0;
        wBRAM_EN <= 0;
        BRAM_RST <= 0;
        done <= 0;
        BRAM_WE <= 0;
        
        for(i=0;i<8192;i=i+1) begin
            #10;
            BRAM_ADDR <= {i, 2'b00};
            rBRAM_EN <= 1;
            wBRAM_EN <= 0;
            BRAM_WE <= 0;
            #7;
            rBRAM_EN <= 0;
            #23;
            wBRAM_EN <= 1;
            BRAM_WE <= 4'b1111;
        end
        #10;
        wBRAM_EN <= 0;
        done <= 1;
        $finish;
    end
    
    always #5 BRAM_CLK = ~BRAM_CLK;
    
    
    my_bram read_BRAM(
        .BRAM_ADDR(BRAM_ADDR),
        .BRAM_CLK(BRAM_CLK),
        .BRAM_WRDATA(32'b0),
        .BRAM_RDDATA(BRAM_RDDATA),
        .BRAM_EN(rBRAM_EN),
        .BRAM_RST(BRAM_RST),
        .BRAM_WE(4'b0),
        .done(0)
    );
    
    my_bram #(BRAM_ADDR_WIDTH, "", "output.txt") write_BRAM(
        .BRAM_ADDR(BRAM_ADDR),
        .BRAM_CLK(BRAM_CLK),
        .BRAM_WRDATA(BRAM_RDDATA),
        .BRAM_RDDATA(BRAM_RDDATA2),
        .BRAM_EN(wBRAM_EN),
        .BRAM_RST(BRAM_RST),
        .BRAM_WE(BRAM_WE),
        .done(done)
    );
    
endmodule
