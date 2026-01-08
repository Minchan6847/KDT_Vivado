`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/01/08 11:18:03
// Design Name: 
// Module Name: top
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


module top(
input clk_125MHz, rst, en,
output [6:0] ssd,
output ssdcat
);

wire clk_6MHz, clk_1Hz;
// 125MHz(input) to 6MHz
clk_wiz_0 PLL_inst(.clk_out1(clk_6MHz), .reset(rst), .locked(), .clk_in1(clk_125MHz));
 
// 6MHz to 1Hz
clk_divider #(.DIV(6000000)) CLK_div(clk_6MHz, rst, clk_1Hz);
// 6MHz to 1MHz
//clk_divider #(.DIV(6)) CLK_div(clk_6MHz, rst, clk_1Hz);

// count up / 1Hz / 00 ~ 99 / [q2][q1] / 1초마다 1씩 증가
wire [3:0] q1, q2;
counter_b CNT_b(.clk(clk_1Hz), .rst(rst), .en(en), .q1(q1), .q2(q2));

// 7-segment decoding
wire [6:0] dec_q1, dec_q2;
decoder_7 DUT_7_1(.q(q1), .dec_q(dec_q1));
decoder_7 DUT_7_2(.q(q2), .dec_q(dec_q2));

// when ssdcat==1, ssd = dec_q1
// when ssdcat==0, ssd = dec_q2
assign ssd = (ssdcat == 1) ? dec_q2 : dec_q1;

// 6MHz to 120Hz
// ssdcat togle 120Hz
clk_divider #(.DIV(50000)) CLK_div2(clk_6MHz, rst, ssdcat);

endmodule



