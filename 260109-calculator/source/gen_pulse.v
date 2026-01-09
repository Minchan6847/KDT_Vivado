`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/01/08 15:53:57
// Design Name: 
// Module Name: gen_pulse
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


module gen_pulse(clk_6mhz, rst, btn_out, btn_pulse);
parameter BTN_WIDTH = 3;  
input clk_6mhz, rst; 
input [BTN_WIDTH-1:0] btn_out; 
output [BTN_WIDTH-1:0] btn_pulse; 

reg [BTN_WIDTH-1:0] btn_out_d1;

always @(posedge clk_6mhz, posedge rst) begin
    if (rst) btn_out_d1 <= 0; 
    else btn_out_d1 <= btn_out;        
end 
assign btn_pulse = btn_out  & (~btn_out_d1); 

endmodule




