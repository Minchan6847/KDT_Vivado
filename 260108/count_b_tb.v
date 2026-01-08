`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/01/08 10:15:52
// Design Name: 
// Module Name: count_b_tb
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


module count_b_tb(
);

reg clk = 0, rst = 1, en = 0;
wire [3:0] q1, q2;
    
initial begin
    #20 rst = 0;
    #10 rst = 1;
    #20 en = 1;
    #80 //rst = 0;
    #20 //rst = 1;
    
    #32400 en = 0;
    
    #40
    $stop;
end

always begin
    #10 clk = ~ clk;
end

counter_b DUT(clk, rst, en, q1, q2);

wire clk_out;
clk_divider DUT2(clk, rst, clk_out);
//clk_divider #(.DIV(10)) DUT2(clk, rst, clk_out);

endmodule
