`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/28/2019 09:09:23 AM
// Design Name: 
// Module Name: tb_lab4
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


module tb();

    //for my IP
    reg [32-1:0] ain;
    reg [32-1:0] bin;
    reg [32-1:0] cin;
    reg [32-1:0] cin2;
    reg rst;
    reg clk;
    wire [32-1:0] res;
    wire [64-1:0] res2;
    wire dvalid;
    
    //for test
    integer i;
    //ranom test vector generation
    initial begin
        clk<=0;
        rst<=0;
        for(i=0;i<32;i=i+1) begin
            ain = $urandom%(2**31);
            bin = $urandom%(2**31);
            cin = $urandom%(2**31);
            cin2 = $urandom;
            #20;
        end
    end
    
    always #5 clk = ~clk;
    
    floating_point_MAC UUT(
        .aclk(clk),
        .aresetn(~rst),
        .s_axis_a_tvalid(1'b1),
        .s_axis_b_tvalid(1'b1),
        .s_axis_c_tvalid(1'b1),
        .s_axis_a_tdata(ain),
        .s_axis_b_tdata(bin),
        .s_axis_c_tdata(cin),
        .m_axis_result_tvalid(dvalid),
        .m_axis_result_tdata(res)
    );
    
    xbip_multadd_MAC UUT2(
        //.CLK(clk),
        //.CE(1'b1),
        .A(ain),
        .B(bin),
        .C({cin,cin2}),
        .SUBTRACT(1'b0),
        .P(res2)
        //.SCLR(rst)
    );
endmodule
