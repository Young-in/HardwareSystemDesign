`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/28/2019 10:47:13 AM
// Design Name: 
// Module Name: tb_array
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


module tb_array(

    );
    reg [31:0] ain0, ain1, ain2, ain3;
    reg [31:0] bin0, bin1, bin2, bin3;
    reg [2:0] cmd;
    wire [31:0] dout0, dout1, dout2, dout3;
    wire [3:0] overflow;
    
    integer i;
    initial begin
        for(i=0;i<32;i=i+1) begin
            ain0 = $urandom;
            ain1 = $urandom;
            ain2 = $urandom;
            ain3 = $urandom;
            
            bin0 = $urandom;
            bin1 = $urandom;
            bin2 = $urandom;
            bin3 = $urandom;
            
            cmd = $urandom % 5;
            #20;
        end
    end
    
    adder_array UUT3(
        .cmd(cmd),
        .ain0(ain0),
        .ain1(ain1),
        .ain2(ain2),
        .ain3(ain3),
        .bin0(bin0),
        .bin1(bin1),
        .bin2(bin2),
        .bin3(bin3),
        .dout0(dout0),
        .dout1(dout1),
        .dout2(dout2),
        .dout3(dout3),
        .overflow(overflow)
    );
endmodule
