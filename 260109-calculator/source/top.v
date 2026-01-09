`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/01/08 11:18:01
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
module top(input clk_125mhz, rst, inout [7:0] key_io, input [2:0] btn, output [6:0] ssd, output ssdcat);

wire clk_6mhz, clk_1hz;
wire [3:0] q1, q2;
wire [6:0] dec_q1, dec_q2;
wire [2:0] btn_out; 
wire [2:0] btn_pulse;

clk_wiz_0 pll_inst(clk_6mhz, rst, , clk_125mhz); //PLL
//clk_divider #(.DIV(6000000) ) clk_div_inst (clk_6mhz, rst, clk_1hz);
/*
gen_trig #(.SIZE(6000000)) gen_trig_inst (clk_6mhz, rst, trig); 
debounce #(.BTN_WIDTH(3)) debounce_inst (clk_6mhz, rst, btn, btn_out); 
gen_pulse #(.BTN_WIDTH(3)) gen_pulse_inst (clk_6mhz, rst, btn_out, btn_pulse);
*/
// keypad_out=5bit / [4]=1(아무키라도 누르면), [3:0]: 어떤 키를 눌렀는지(숫자 5 -> 0101)
//숫자 5 누르면 keypad_out: 5'b1_0101 = 5'h15
//문자 A 누르면 keypad_out: 5'b1_1010 = 5'h1A
wire [4:0] keypad_out, keypad_clean, keypad_pulse;
keypad #(.CLK_KHZ(6000)) keypad_inst(clk_6mhz, rst, key_io[7:4], key_io[3:0], keypad_out); // keypad_out (우리가 어떤 key를 눌렀는지)
debounce #(.BTN_WIDTH(5)) debounce_inst_k (clk_6mhz, rst, keypad_out, keypad_clean);
gen_pulse #(.BTN_WIDTH(5)) gen_pulse_inst_k (clk_6mhz, rst, keypad_clean, keypad_pulse);

calculator calculator_inst (clk_6mhz, rst, keypad_pulse, q1, q2);

//counter counter_inst (clk_6mhz, rst, trig, btn_pulse, q1, q2);

dec7 dec_inst_1 (q1, dec_q1);
dec7 dec_inst_2 (q2, dec_q2);

// when sscat=0 일때, ssd = dec_q1 을 선택, when ssdcat = 1일때, ssd = dec_q2를 선택
assign ssd = (ssdcat == 0)? dec_q1 : dec_q2;
// ssdcat=0과 1을 왓다갔다 빠르게,,,,(1초에 120번) 
clk_divider #(.DIV(50000) ) ssdcat_inst (clk_6mhz, rst, ssdcat);


endmodule









