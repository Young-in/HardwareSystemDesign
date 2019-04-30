`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/30 19:10:37
// Design Name: 
// Module Name: main
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


module main(
    input gclk,
    input reset,
    output [7:0] LED
    );
    
    reg[26:0] counter;
    reg[7:0] LED_r;
    
    assign LED = LED_r;
    
    always @(posedge gclk) begin
        if(reset==1) begin
            counter <= 27'd100000000;
            LED_r <= 0;
        end
        else if(counter == 0) begin
            counter <= 27'd100000000;
            LED_r <= LED_r + 1; 
        end
        else begin
            counter <= counter - 1;
        end 
    end
    wire aclk;
    
endmodule
