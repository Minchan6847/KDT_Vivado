`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/01/08 10:08:24
// Design Name: 
// Module Name: counter
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


module counter(input clk, rst, en, input [2:0] btn_pulse, output reg [3:0] q1, q2     );

reg pause; 
always @(posedge clk, posedge rst) begin
    if (rst) pause <= 0; // pause =1 멈춤, pause=0 진행
    else if (btn_pulse[0]) pause <= ~pause; 
end  

//q1: 0~9까지 세는 카운터
always @(posedge clk, posedge rst) begin
    if (rst) q1 <= 0; 
    else if (en & ~pause ) begin
        if (q1 == 9) q1 <= 0; 
        else q1 <= q1 + 1; 
    end
    else if (btn_pulse[1]) begin
        if (q1 == 9) q1 <= 0; 
        else q1 <= q1 + 1; 
    end 

end

wire trig; 
assign trig = (q1 == 9)? 1 : 0; 

//q2: 0~9까지 세는 카운터 (q1==9일때만 counting)
always @(posedge clk, posedge rst) begin //clk 6mhz
    if (rst) q2 <= 0; 
    else if ((trig & en & ~pause) | (btn_pulse[1] & trig)  ) begin
        if (q2 == 9) q2 <= 0; 
        else q2 <= q2 + 1; 
    end
    else if (btn_pulse[2]) begin
        if (q2 == 9) q2 <= 0; 
        else q2 <= q2 + 1; 
    end 

end


endmodule









