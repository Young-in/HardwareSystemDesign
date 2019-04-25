`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2019 09:40:40 AM
// Design Name: 
// Module Name: pe_tb
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


module pe_tb(

    );
    parameter L_RAM_SIZE = 4;
    reg start; //input
    wire done; //output
    reg aclk; //input
    reg aresetn; //input
    wire [L_RAM_SIZE:0] rdaddr; //output
    reg [31:0] rddata; //input
    wire [31:0] wrdata; //output
    
    reg [31:0] in [0:31];
    
    integer i;
    
    initial begin
        aclk <= 0;
        start <= 0;
        aresetn <= 0;
        
        $readmemh("din.txt", in);
        
        #10;
        start <= 1;
        aresetn <= 1;
        
    end
    
    
    
    always #5 aclk <= ~aclk;
    
    always @(negedge aclk) begin
        rddata <= in[rdaddr];
    end
    
    pe_con pe(
        .start(start),
        .done(done),
        .aclk(aclk),
        .aresetn(aresetn),
        .rdaddr(rdaddr),
        .rddata(rddata),
        .wrdata(wrdata));
    
//       input start,
//       output done,
//       input aclk,
//       input aresetn,
//       output [L_RAM_SIZE:0] rdaddr,	//address from PE
//	    input [31:0] rddata,
//	    output reg [31:0] wrdata
endmodule
