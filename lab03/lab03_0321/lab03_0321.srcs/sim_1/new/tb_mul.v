`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/21/2019 09:24:43 AM
// Design Name: 
// Module Name: tb_mul
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


module tb_mul(

    );
    
    reg[31:0] ain;
    reg[31:0] bin;
    wire[63:0] dout;
    
initial begin
    ain = 62;
    bin = 891;
end

    my_mul T2(.ain(ain), .bin(bin), .dout(dout));
endmodule
