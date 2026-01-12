`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/01/12 14:02:35
// Design Name: 
// Module Name: fir8
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


module fir8(clk, rst, cwe, coef, din, dout); 

parameter WB = 8; // din의 bit 수
parameter C_WB = 8; // coef의 bit 수

input clk;
input rst;
input cwe; //coefficient write enable
input [C_WB - 1:0] coef; //coefficient
input [WB - 1:0] din; //x[n]
output [WB + C_WB + 2:0] dout;

reg [C_WB - 1:0] coef_saved [0:7]; // C_WB 비트 레지스터 8개 선언
reg [WB - 1:0] din_saved [0:7];
wire [WB + C_WB - 1:0] dout_saved [0:7];

integer i;

// -------------- 1. shift register for coefficient (교재 p144) -------------- //
// cwe = 1일 때만 이동
always @(posedge clk or posedge rst) begin
    if (rst) begin
        for (i = 0; i < 8; i = i + 1) begin
            coef_saved[i] <= 8'h00;
        end
    end
    else if(cwe) begin // coef -> 0 / 1 / 2 / 3 / 4 / 5 / 6 / 7
        coef_saved[0] <= coef;
        for (i = 1; i < 8; i = i + 1) begin
            coef_saved[i] <= coef_saved[i-1];
        end
    end
end

// 2. shift register for din
// 항상 이동
always @(posedge clk or posedge rst) begin
    if (rst) begin
        for (i = 0; i < 8; i = i + 1) begin
            din_saved[i] <= 8'h00;
        end
    end
    else begin // din -> 0 / 1 / 2 / 3 / 4 / 5 / 6 / 7
        din_saved[0] <= din;
        for (i = 1; i < 8; i = i + 1) begin
            din_saved[i] <= din_saved[i-1];
        end
    end
end

// -------------------------- 3. multiflyer 8개 -------------------------- //
// 보울리 곱셈기 사용(signed multiplier)
multiplier #(.WB(8)) m0(din_saved[0], coef_saved[0], dout_saved[0]);
multiplier #(.WB(8)) m1(din_saved[1], coef_saved[1], dout_saved[1]);
multiplier #(.WB(8)) m2(din_saved[2], coef_saved[2], dout_saved[2]);
multiplier #(.WB(8)) m3(din_saved[3], coef_saved[3], dout_saved[3]);
multiplier #(.WB(8)) m4(din_saved[4], coef_saved[4], dout_saved[4]);
multiplier #(.WB(8)) m5(din_saved[5], coef_saved[5], dout_saved[5]);
multiplier #(.WB(8)) m6(din_saved[6], coef_saved[6], dout_saved[6]);
multiplier #(.WB(8)) m7(din_saved[7], coef_saved[7], dout_saved[7]);

// -------------------------- 4. adder_tree --> dout -------------------------- //
// overflow를 막기 위한 덧셈기 참조
wire [WB + C_WB:0] dout_saved_sum1 [0:3];
wire [WB + C_WB + 1:0] dout_saved_sum2 [0:1];

// sum before sign extension
assign dout_saved_sum1[0] = {dout_saved[0][WB + C_WB - 1], dout_saved[0]} + {dout_saved[1][WB + C_WB - 1], dout_saved[1]};
assign dout_saved_sum1[1] = {dout_saved[2][WB + C_WB - 1], dout_saved[2]} + {dout_saved[3][WB + C_WB - 1], dout_saved[3]};
assign dout_saved_sum1[2] = {dout_saved[4][WB + C_WB - 1], dout_saved[4]} + {dout_saved[5][WB + C_WB - 1], dout_saved[5]};
assign dout_saved_sum1[3] = {dout_saved[6][WB + C_WB - 1], dout_saved[6]} + {dout_saved[7][WB + C_WB - 1], dout_saved[7]};

// sum before sign extension
assign dout_saved_sum2[0] = {dout_saved_sum1[0][WB + C_WB], dout_saved_sum1[0]} + {dout_saved_sum1[1][WB + C_WB], dout_saved_sum1[1]};
assign dout_saved_sum2[1] = {dout_saved_sum1[2][WB + C_WB], dout_saved_sum1[2]} + {dout_saved_sum1[3][WB + C_WB], dout_saved_sum1[3]};

// sum before sign extension
assign dout = {dout_saved_sum2[0][WB + C_WB + 1], dout_saved_sum2[0]} + {dout_saved_sum2[1][WB + C_WB + 1], dout_saved_sum2[1]};


endmodule




