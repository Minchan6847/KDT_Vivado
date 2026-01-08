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
input clk, rst, en,
output reg [3:0] q1, q2
);

// q1: 0 ~ 9 count up
always @(posedge clk, posedge rst) begin
    if(rst) begin
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

wire trig;
assign trig = (q1 == 9) ? 1 : 0;

// q2: 0 ~ 9  count up / when q1 == 9
always @(posedge clk, posedge rst) begin
    if(rst) begin
        q2 <= 0;
    end
    else if(trig & en) begin
        if(q2 == 9) begin
            q2 <= 0;
        end
        else begin
            q2 <= q2 + 1;
        end
    end
end

endmodule
