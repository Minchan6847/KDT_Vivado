`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/01/08 10:37:40
// Design Name: 
// Module Name: clk_divider
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


module clk_divider(input clk, rst, output reg clk_out);
parameter DIV = 100; // clk_out(MHz) = clk(MHz) / DIV

reg [31:0] cnt;
always @(posedge clk, posedge rst) begin
    if (rst) cnt <= 0; 
    else if (cnt == DIV/2-1) cnt <= 0; 
    else cnt <= cnt + 1; 
end

assign trig = (cnt == DIV/2-1)? 1 : 0;

always @(posedge clk, posedge rst) begin
    if (rst) clk_out <= 0; 
    else if (trig) clk_out <= ~clk_out; 

end


endmodule

















