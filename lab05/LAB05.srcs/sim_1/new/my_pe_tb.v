`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/09/2019 05:26:19 PM
// Design Name: 
// Module Name: my_pe_tb
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


module my_pe_tb(

    );
    parameter L_RAM_SIZE = 6;
    
    reg aclk;
    reg aresetn;
    reg [31:0] ain;
    reg [31:0] din;
    reg [31:0] mem [31:0];
    
    reg [L_RAM_SIZE - 1:0] addr;
    reg we;
    reg valid;
    wire dvalid;
    wire [31:0] dout;
    
    integer i;
    
    initial begin
        aclk <= 0;
        aresetn <= 0;
        we <= 0;
        valid <= 0;
        $readmemh("din.txt", mem);
        for(i = 0; i < 16; i = i + 1) begin
            #3;
            addr <= i;
            din <= mem[i];
            we <= 1;
            #7;
            we <= 0;
        end
        $readmemh("ain.txt", mem);
        aresetn <= 1;
        #10;
        for(i = 0; i < 16; i = i + 1) begin
            #2;
            addr <= i;
            ain <= mem[i];
            #2;
            valid <= 1;
            #6;
            valid <= 0;
            #160;
        end
        $finish;
    end
    
    always #5 aclk = ~aclk;
    
    
    
    
    
    my_pe PE(
    .aclk(aclk),
    .aresetn(aresetn),
    .ain(ain),
    
    .din(din),
    .addr(addr),
    .we(we),
    
    .valid(valid),
    
    .dvalid(dvalid),
    .dout(dout)
);

endmodule
