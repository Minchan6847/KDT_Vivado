`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/01/08 12:43:05
// Design Name: 
// Module Name: top_tb
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


module top_tb(
);

reg clk_125MHz = 0, rst = 0, en = 0;
wire [3:0] q1, q2;

initial begin
    #20 rst = 1;
    #10 rst = 0;
    #20 en = 1;
    #80 //rst = 0;
    #20 //rst = 1;
    
    #32400 en = 0;
    
    #40
    $stop;
end

always begin
    #4 clk_125MHz = ~ clk_125MHz;
end

top DUT(.clk_125MHz(clk_125MHz), .rst(rst), .ssd(ssd), .ssdcat(ssdcat));

endmodule



