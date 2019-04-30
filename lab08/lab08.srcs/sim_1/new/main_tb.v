`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/30 19:45:47
// Design Name: 
// Module Name: main_tb
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


module main_tb(

    );
    wire[7:0] LED;
    reg gclk;
    reg reset;
    
    initial begin
        gclk <= 0;
        reset <= 1;
        #20;
        reset <= 0;
    end
    
    always #1 gclk = ~gclk;
    
    main main1 (.gclk(gclk), .reset(reset), .LED(LED));
    
endmodule
