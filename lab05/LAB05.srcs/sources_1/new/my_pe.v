`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/04/2019 09:11:16 AM
// Design Name: 
// Module Name: my_pe
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


module my_pe #(
    parameter L_RAM_SIZE = 6
)
(
    input aclk,
    input aresetn,
    input [31:0] ain,
    
    input [31:0] din,
    input [L_RAM_SIZE-1:0] addr,
    input we,
    
    input valid,
    
    output dvalid,
    output [31:0] dout
);

(* ram_style = "block" *) reg [31:0] peram [0:2**L_RAM_SIZE - 1];

    reg [31:0] Psum;
    wire [31:0] buffer;
    
    reg [31:0] out;
    
    assign dout = (dvalid == 1) ? Psum : 32'b0;
    
    always @(posedge aclk) begin
        if(we == 1) peram[addr] = din;
        if(~aresetn) Psum = 0;
    end
    
    always @(posedge dvalid) begin
        #2 Psum = buffer;
    end

    floating_MAC mac(
        .aclk(aclk),
        .aresetn(aresetn),
        
        .s_axis_a_tdata(ain),
        .s_axis_a_tvalid(valid),
        
        .s_axis_b_tdata(peram[addr]),
        .s_axis_b_tvalid(valid),
        
        .s_axis_c_tdata(Psum),
        .s_axis_c_tvalid(valid),
        
        .m_axis_result_tdata(buffer),
        .m_axis_result_tvalid(dvalid)
    );
endmodule
