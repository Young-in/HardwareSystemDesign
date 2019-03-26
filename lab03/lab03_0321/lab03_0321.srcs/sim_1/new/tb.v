`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/21/2019 09:14:28 AM
// Design Name: 
// Module Name: tb
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


module tb_add(

    );
    
    reg[31:0] ain;
    reg[31:0] bin;
    wire[31:0] dout;
    wire overflow;
    
initial begin
    ain = 32'h7FFFFFFF;
    bin = 32'h7FFFFFFF;
end
    
    my_add T1(.ain(ain), .bin(bin), .dout(dout), .overflow(overflow));

endmodule
