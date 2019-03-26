`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/21/2019 09:32:54 AM
// Design Name: 
// Module Name: tb_mac
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


module tb_mac(

    );

    reg[31:0] ain;
    reg[31:0] bin;
    wire[63:0] dout;
    reg en;
    reg clk;
    
initial begin
    ain = 3;
    bin = 4;
    en = 0;
    clk = 0;
    #10 en = 1;
    #1000 $finish;
end

always begin
    #5 clk = ~clk;
end

always begin
    #10
    ain = $random;
    bin = $random;
end

    my_mac T3(.ain(ain), .bin(bin), .dout(dout), .en(en), .clk(clk));
endmodule
