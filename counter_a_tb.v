`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/01/07 16:25:52
// Design Name: 
// Module Name: counter_a_tb
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


module counter_a_tb(

    );
    
reg clk = 0, rst = 1, en = 0;
wire [3:0] q1, q2, q3, q4;
    
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

counter_a DUT(clk, rst, en, q1, q2, q3, q4);

endmodule
