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
input clk_125MHz, rst,
input [2:0] btn,
output [6:0] ssd,
output ssdcat
);

//---------------------- Crystal(125MHz) to CLK(6MHz) ----------------------//

// 125MHz(input) to 6MHz
wire clk_6MHz, clk_1Hz;
clk_wiz_0 PLL_inst(.clk_out1(clk_6MHz), .reset(rst), .locked(), .clk_in1(clk_125MHz));

//---------------------- Btn(debounce -> one-hot) ----------------------//
/*
// debounce btn
wire [2:0] btn_out;
debounce #(.BTN_WIDTH(3)) debounce_inst(clk_6MHz, rst, btn, btn_out);

// one-hot
wire [2:0] btn_pulse;
gen_pulse #(.BTN_WIDTH(3)) GEN_pulse_inst(clk_6MHz, rst, btn_out, btn_pulse);
*/
//---------------------- One Shot Enable ----------------------//

reg [2:0] btn_1, btn_2;
wire [2:0] btn_OSE;
always @(posedge clk_6MHz, posedge rst) begin
    if(rst) begin
        btn_1 <= 0;
        btn_2 <= 0;
    end
    else begin
        btn_1 <= btn;
        btn_2 <= btn_1;
    end
end

assign btn_OSE = btn_1 & ~ btn_2;

//---------------------- gen Pause/Resume signal ----------------------//

reg en;
//always @(posedge btn_pulse[2], posedge rst) begin
always @(posedge btn_OSE[2], posedge rst) begin
    if(rst) begin
        en <= 0;
    end
    else begin
        en <= ~ en;
    end
end

//---------------------- Count up ----------------------//

// 6MHz to 1Hz
clk_divider #(.DIV(6000000)) CLK_div(clk_6MHz, rst, clk_1Hz);
//clk_divider #(.DIV(60)) CLK_div(clk_6MHz, rst, clk_1Hz);

wire [3:0] q1, q2;
// count up / 1Hz / 00 ~ 99 / [q2][q1] / 1초마다 1씩 증가
//counter_b CNT_b(.clk(clk_1Hz), .rst(rst), .en(en), .q1_up(btn_pulse[0]), .q2_up(btn_pulse[1]), .q1(q1), .q2(q2));
counter_b CNT_b(.clk(clk_1Hz), .rst(rst), .en(en), .q1_up(btn_OSE[0]), .q2_up(btn_OSE[1]), .q1(q1), .q2(q2));

/*
 // 1초마다 count up
wire trig;
gen_trig #(.SIZE(6000000)) GEN_trig_inst(clk_6MHz, rst, trig);
counter_b CNT_b(.clk(clk_6MHz), .rst(rst), .en(trig), .q1(q1), .q2(q2));

//버튼 누를 때 마다 count up
counter_b CNT_b(.clk(clk_6MHz), .rst(rst), .en(btn_pulse[0]), .q1(q1), .q2(q2));
*/

//---------------------- 7-Segment ----------------------//

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

//-----------------------------------------------------------//

endmodule



