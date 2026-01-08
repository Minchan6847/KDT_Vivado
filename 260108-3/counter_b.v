`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/01/08 10:08:19
// Design Name: 
// Module Name: counter_b
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


module counter_b(
input clk, rst, en, q1_up, q2_up,
output reg [3:0] q1, q2
);

reg q1_event_clear;
reg q1_up_event; // q1_up 발생 여부를 저장하는 플래그

// 1. q1_up의 상승 엣지를 비동기적으로 캡처
always @(posedge q1_up or posedge rst or posedge q1_event_clear) begin
    if (rst)
        q1_up_event <= 1'b0;
    else if (q1_event_clear) // q2가 업데이트된 후 클리어
        q1_up_event <= 1'b0;
    else
        q1_up_event <= 1'b1;
end

// q1: 0 ~ 9  count up
always @(posedge clk or posedge rst) begin
    if (rst) begin
        q1 <= 0;
        q1_event_clear <= 0;
    end else begin
        if ((en) || q1_up_event) begin
            q1 <= (q1 == 9) ? 0 : q1 + 1;
            q1_event_clear <= 1'b1; // 처리가 완료됨을 알림
        end else begin
            q1_event_clear <= 1'b0;
        end
    end
end

wire trig;
assign trig = (q1 == 9) ? 1 : 0;

// ------------- q2 -------------//

reg q2_event_clear;
reg q2_up_event; // q2_up 발생 여부를 저장하는 플래그

// 1. q2_up의 상승 엣지를 비동기적으로 캡처
always @(posedge q2_up or posedge rst or posedge q2_event_clear) begin
    if (rst)
        q2_up_event <= 1'b0;
    else if (q2_event_clear) // q2가 업데이트된 후 클리어
        q2_up_event <= 1'b0;
    else
        q2_up_event <= 1'b1;
end

// q2: 0 ~ 9  count up / when q1 == 9
always @(posedge clk or posedge rst) begin
    if (rst) begin
        q2 <= 0;
        q2_event_clear <= 0;
    end else begin
        if ((en & trig) || q2_up_event) begin
            q2 <= (q2 == 9) ? 0 : q2 + 1;
            q2_event_clear <= 1'b1; // 처리가 완료됨을 알림
        end else begin
            q2_event_clear <= 1'b0;
        end
    end
end

endmodule
