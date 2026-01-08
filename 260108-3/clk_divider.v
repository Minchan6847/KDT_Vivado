`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/01/08 10:37:34
// Design Name: 
// Module Name: clk_divider
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


module clk_divider(
input clk, rst,
output reg clk_out
);

parameter DIV = 10;
// Frequency:   clk_out = clk / DIV
// Period:      clk_out = clk * DIV

// cnt: 0 ~ 99

reg [31:0] cnt;

always @(posedge clk, posedge rst) begin
    if(rst) begin
        cnt <= 0;
    end
    else begin
        if(cnt == DIV / 2 - 1) begin
            cnt <= 0;
        end
        else begin
            cnt <= cnt + 1;
        end
    end
end

wire trig;
assign trig = (cnt == DIV / 2 - 1) ? 1 : 0;

// 
always @(posedge clk, posedge rst) begin
    if(rst) begin
        clk_out <= 0;
    end
    else if(trig) begin
        clk_out <= ~ clk_out;
    end
end

endmodule



