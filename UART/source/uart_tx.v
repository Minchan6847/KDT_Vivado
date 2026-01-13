`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/01/13 14:26:39
// Design Name: 
// Module Name: uart_tx
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

// speed: 115200, data: 8bit, parity: none, stop bit: 1 bit
module uart_tx(clk, rst, btn_sw_pulse, dip_sw, uart_txd);

input clk, rst, btn_sw_pulse;
input [3:0] dip_sw;
output reg uart_txd;

reg en;
wire trig;

//====================== FSM ======================//

//----------------- STEP 1 - state parameter -----------------//
parameter IDLE = 0, START = 1, D0 = 2, D1 = 3, D2 = 4, D3 = 5, D4 = 6, D5 = 7, D6 = 8, D7 = 9, STOP = 10;
reg [3:0] c_state, n_state;

//----------------- STEP 2 - n_state -----------------//
always @(*) begin
    case(c_state)
        IDLE    : n_state = btn_sw_pulse    ? START : IDLE;
        START   : n_state = trig            ? D0    : START;
        D0      : n_state = trig            ? D1    : D0;
        D1      : n_state = trig            ? D2    : D1;
        D2      : n_state = trig            ? D3    : D2;
        D3      : n_state = trig            ? D4    : D3;
        D4      : n_state = trig            ? D5    : D4;
        D5      : n_state = trig            ? D6    : D5;
        D6      : n_state = trig            ? D7    : D6;
        D7      : n_state = trig            ? STOP  : D7;
        STOP    : n_state = trig            ? IDLE  : STOP;
        default : n_state = IDLE;
    endcase
end

// 0 ~ 520 까지 세는 카운터, cnt == 520일때 trig = 1
gen_trig #(.SIZE(521)) gen_trig_inst(clk, rst, en, trig);

always @(posedge clk or posedge rst) begin
    if(rst || c_state == IDLE) begin
        en <= 0;
    end
    else if(c_state == START || D0 || D1 || D2 || D3 || D4 || D5 || D6 || D7 || STOP) begin
        en <= 1;
    end
end

//----------------- STEP 3 - c_state -----------------//
always @(posedge clk or posedge rst) begin
    if(rst) begin
        c_state <= IDLE;
    end
    else begin
        c_state <= n_state;
    end
end

//----------------- STEP 4 - output -----------------//
always @(*) begin
    case(c_state)
        IDLE    : uart_txd = 1;
        START   : uart_txd = 0;
        D0      : uart_txd = dip_sw[0];
        D1      : uart_txd = dip_sw[1];
        D2      : uart_txd = dip_sw[2];
        D3      : uart_txd = dip_sw[3];
        D4      : uart_txd = 1;
        D5      : uart_txd = 1;
        D6      : uart_txd = 0;
        D7      : uart_txd = 0;
        STOP    : uart_txd = 1;
        default : uart_txd = 1;
    endcase
end


endmodule
