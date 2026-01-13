`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/01/13 15:51:08
// Design Name: 
// Module Name: gen_trig
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


module gen_trig(clk, rst, en, trig);

parameter SIZE = 521;

input clk, rst, en;
output trig;

reg [9:0] cnt;

always @(posedge clk or posedge rst) begin
    if(rst) begin
        cnt <= 0;
    end
    else if(en) begin
        if(cnt == SIZE - 1) begin
            cnt <= 0;
        end
        else begin
            cnt <= cnt + 1;
        end
    end
end

assign trig = (cnt == SIZE - 1) ? 1 : 0; 

endmodule
