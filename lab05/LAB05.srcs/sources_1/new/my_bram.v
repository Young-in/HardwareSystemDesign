`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/04/2019 09:10:52 AM
// Design Name: 
// Module Name: my_bram
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


module my_bram # (
    parameter integer BRAM_ADDR_WIDTH = 15, // 4x8192
    parameter INIT_FILE = "input.txt",
    parameter OUT_FILE = "output.txt"
)(
    input wire [BRAM_ADDR_WIDTH-1:0] BRAM_ADDR,
    input wire BRAM_CLK,
    input wire [31:0] BRAM_WRDATA,
    output reg [31:0] BRAM_RDDATA,
    input wire BRAM_EN,
    input wire BRAM_RST,
    input wire [3:0] BRAM_WE,
    input wire done
);

    reg [31:0] mem[0:8191];
    wire [BRAM_ADDR_WIDTH-3:0] addr = BRAM_ADDR[BRAM_ADDR_WIDTH-1:2];
    reg [31:0] dout;
    reg [1:0] counter;
    
    reg [31:0] RREG[1:0];
    reg RREG_V[1:0];
    reg [BRAM_ADDR_WIDTH-3:0] AREG;
    reg [31:0] WREG;
    reg [3:0] WREG_V;
    wire [31:0] mask;
    
     initial begin
        if (INIT_FILE != "") begin
            $readmemh(INIT_FILE, mem);
        end
        wait (done) begin
            $writememh(OUT_FILE, mem);
        end
     end
     
     assign mask = {{8{WREG_V[0]}}, {8{WREG_V[1]}},{8{WREG_V[2]}}, {8{WREG_V[3]}}};
     always @(posedge BRAM_CLK) begin
        if(BRAM_RST == 1) begin
            BRAM_RDDATA <= 0;
        end
        else begin
            if(RREG_V[1] == 1) begin
                BRAM_RDDATA = RREG[1];
            end
            
            mem[AREG] = (mem[AREG] & (~mask)) | (WREG & mask);
            
            {RREG_V[1], RREG[1]} = {RREG_V[0], RREG[0]};
            {RREG_V[0], RREG[0]} = {(BRAM_EN & (!BRAM_WE)), mem[addr]};
            WREG_V = {4{BRAM_EN}} & BRAM_WE;
            AREG = addr;
            WREG = BRAM_WRDATA;
        end
     end
endmodule
