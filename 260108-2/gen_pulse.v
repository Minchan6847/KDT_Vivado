`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/01/08 15:53:53
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


module gen_pulse
#(BTN_WIDTH = 3)
(
input clk_6MHz, rst,
input [BTN_WIDTH - 1:0] btn_out,
output [BTN_WIDTH - 1:0] btn_pulse
);

reg [BTN_WIDTH - 1:0] btn_out_d;

//one-hot btn
always @(posedge clk_6MHz, posedge rst) begin
    if(rst) begin
        btn_out_d <= 0;
    end
    else btn_out_d <= btn_out;
end

assign btn_pulse = btn_out & (~ btn_out_d);

endmodule
