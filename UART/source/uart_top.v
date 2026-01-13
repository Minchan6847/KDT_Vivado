`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/01/13 16:56:45
// Design Name: 
// Module Name: uart_top
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


module uart_top(clk_125MHz, rst, btn_sw, dip_sw, uart_rxd, uart_txd, led);

input clk_125MHz, rst, btn_sw;
input [3:0] dip_sw;
input uart_rxd;
output uart_txd;
output [3:0] led;

wire btn_sw_out, btn_sw_pulse;
wire [7:0] uart_rx_data;

// 125 MHz to 60 MHz
clk_wiz_0 clk_inst (.clk_out1(clk), .reset(rst), .locked(), .clk_in1(clk_125MHz));

// btn_sw to btn_sw_out(debounced) to btn_sw_pulse
debounce #(.BTN_WIDTH(1)) debounce_inst(clk, rst, btn_sw, btn_sw_out);
gen_pulse #(.BTN_WIDTH(1)) gen_pulse_inst(clk, rst, btn_sw_out, btn_sw_pulse);

uart_tx uart_tx_inst(clk, rst, btn_sw_pulse, dip_sw, uart_txd);
uart_rx uart_rx_inst(clk, rst, uart_rxd, uart_rx_data);

assign led = uart_rx_data[3:0];


endmodule



