`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/01/08 00:18:00
// Design Name: 
// Module Name: counter_a
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


module counter_a(
input clk, rst, en,
output reg [3:0] q1, q2, q3, q4
);

wire trig1, trig2, trig3;

// 1. counter (q1): 0~9
always @(posedge clk, negedge rst) begin
    if(~rst) begin
        q1 <= 0;
    end
    else if(en) begin
        if(q1 == 9) begin
            q1 <= 0;
        end
        else begin
            q1 <= q1 + 1;
        end
    end
end

// q1==9일 때 1이 되는 trig 신호 만들기
assign trig1 = (q1 == 9) ? 1 : 0;

// 2. counter (q2): 0~5
always @(posedge clk, negedge rst) begin
    if(~rst) begin
        q2 <= 0;
    end
    else if(trig1) begin
        if(q2 == 5) begin
            q2 <= 0;
        end
        else begin
            q2 <= q2 + 1;
        end
    end
end
assign trig2 = (q2 == 5 && trig1) ? 1 : 0;


// 3. counter (q3): 0~9
always @(posedge clk, negedge rst) begin
    if(~rst) begin
        q3 <= 0;
    end
    else if(trig4) begin
        q3 <= 0;
    end
    else if(trig2) begin
        if(q3 == 9) begin
            q3 <= 0;
        end
        else begin
            q3 <= q3 + 1;
        end
    end
end

assign trig3 = (q3 == 9 && trig2) ? 1 : 0;

// 4. counter (q4): 0~2
always @(posedge clk, negedge rst) begin
    if(~rst) begin
        q4 <= 0;
    end
    else if(trig3) begin
        q4 <= q4 + 1;
    end
    else if(trig4) begin
        q4 <= 0;
    end
end

assign trig4 = (q4 == 2 && q3 == 3 && trig2) ? 1 : 0;

endmodule



