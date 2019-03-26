`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/21/2019 09:27:38 AM
// Design Name: 
// Module Name: my_mac
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


module my_mac #(
    parameter BITWIDTH = 32
)
(
    input [BITWIDTH-1:0] ain,
    input [BITWIDTH-1:0] bin,
    input en,
    input clk,
    output reg [2*BITWIDTH-1:0] dout
);
    wire [2*BITWIDTH-1:0] mul;
    wire [2*BITWIDTH-1:0] acc;
    
    always @(posedge clk) begin

        if (en == 0) begin
            dout = 0;
        end
        else begin
            dout = acc;
        end
            
    end
    my_mul M1(.ain(ain), .bin(bin), .dout(mul));
    my_add #(2*BITWIDTH) A1(.ain(mul), .bin(dout), .dout(acc)); 
    
endmodule
