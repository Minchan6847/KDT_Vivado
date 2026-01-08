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
input [2:0] btn,
output [6:0] ssd,
output ssdcat
);

// 125MHz(input) to 6MHz
wire clk_6MHz, clk_1Hz;
clk_wiz_0 PLL_inst(.clk_out1(clk_6MHz), .reset(rst), .locked(), .clk_in1(clk_125MHz));

// debounce btn
wire [2:0] btn_out;
debounce #(.BTN_WIDTH(3)) debounce_inst(clk_6MHz, rst, btn, btn_out);

// one-hot
wire [2:0] btn_pulse;
gen_pulse #(.BTN_WIDTH(3)) GEN_pulse_inst(clk_6MHz, rst, btn_out, btn_pulse);

// 6MHz to 1Hz
clk_divider #(.DIV(6000000)) CLK_div(clk_6MHz, rst, clk_1Hz);

// count up / 1Hz / 00 ~ 99 / [q2][q1] / 1초마다 1씩 증가
wire [3:0] q1, q2;
//counter_b CNT_b(.clk(clk_1Hz), .rst(rst), .en(en), .q1(q1), .q2(q2));

wire trig;
counter_b CNT_b(.clk(clk_6MHz), .rst(rst), .en(trig), .q1(q1), .q2(q2));
//counter_b CNT_b(.clk(clk_6MHz), .rst(rst), .en(btn_pulse[0]), .q1(q1), .q2(q2));
gen_trig #(.SIZE(6000000)) GEN_trig_inst(clk_6MHz, rst, trig);

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



