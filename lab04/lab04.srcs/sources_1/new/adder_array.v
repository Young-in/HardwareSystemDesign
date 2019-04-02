`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/28/2019 10:25:07 AM
// Design Name: 
// Module Name: adder_array
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


module adder_array #(parameter BITWIDTH = 32)
        ( cmd, ain0, ain1, ain2, ain3, 
        bin0, bin1, bin2, bin3, 
        dout0, dout1, dout2, dout3, overflow
    );
    
    input [2:0] cmd;
    input [BITWIDTH-1:0] ain0, ain1, ain2, ain3;
    input [BITWIDTH-1:0] bin0, bin1, bin2, bin3;
    output [BITWIDTH-1:0] dout0, dout1, dout2, dout3;
    output [3:0] overflow;
    
    wire c0, c1, c2, c3;
    wire [BITWIDTH-1:0] ain[0:3];
    wire [BITWIDTH-1:0] bin[0:3];
    wire [BITWIDTH-1:0] dout[0:3];
//    wire [32*4-1+4:0] dmask;
//    wire [32:0] ones = 33'h1ffffffff;
//    wire [32:0] zeroes = 33'h0;
    
    assign {ain[0], ain[1], ain[2], ain[3]} = {ain0, ain1, ain2, ain3};
    assign {bin[0], bin[1], bin[2], bin[3]} = {bin0, bin1, bin2, bin3};
    assign {dout0, dout1, dout2, dout3} = {dout[0], dout[1], dout[2], dout[3]};
    genvar i;
    generate for (i = 0; i < 4; i = i + 1) begin: bit
        my_add ADD(.ain((cmd[2] || cmd == i) ? ain[i] : 0), .bin((cmd[2] || cmd == i) ? bin[i] : 0), .dout(dout[i]), .overflow(overflow[i]));
//        assign dout[i] = (cmd[2] == 1'b1 || cmd == i) ? ain[i] + bin[i] : 0;
//        assign overflow[i] = (cmd[2] == 1'b1 || cmd == i) ? (ain[i][BITWIDTH-1] == bin[i][BITWIDTH-1]) && (ain[i][BITWIDTH-1] != dout[i][BITWIDTH-1]) : 0;
    end endgenerate
    
//    assign ain = {1'b0, ain0, 1'b0, ain1, 1'b0, ain2, 1'b0, ain3};
//    assign bin = {1'b0, bin0, 1'b0, bin1, 1'b0, bin2, 1'b0, bin3};
//    assign dout = ain + bin;
    
//    assign {c0, dout0, c1, dout1, c2, dout2, c3, dout3} = dout & dmask;
    
//    assign overflow[0] = (ain0[31] == bin0[31]) && (ain0[31] != dout0[31]); 
//    assign overflow[1] = (ain1[31] == bin1[31]) && (ain1[31] != dout1[31]); 
//    assign overflow[2] = (ain2[31] == bin2[31]) && (ain2[31] != dout2[31]); 
//    assign overflow[3] = (ain3[31] == bin3[31]) && (ain3[31] != dout3[31]); 
    
    
//    assign dmask = (cmd == 0) ? {ones, zeroes, zeroes, zeroes} :
//                      (cmd == 1) ? {zeroes, ones, zeroes, zeroes} :
//                      (cmd == 2) ? {zeroes, zeroes, ones, zeroes} :
//                      (cmd == 3) ? {zeroes, zeroes, zeroes, ones} :
//                      (cmd == 4) ? {ones, ones, ones, ones} :
//                      {zeroes, zeroes, zeroes, zeroes}; 
endmodule
