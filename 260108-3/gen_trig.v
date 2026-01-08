`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/01/08 15:50:33
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


module gen_trig(
input clk_6MHz, rst,
output trig
);

parameter SIZE = 6000000;

reg [31:0] cnt;
always @(posedge clk_6MHz, posedge rst) begin
    if(rst) begin
        cnt <= 0;
    end
    else begin
        if(cnt == SIZE - 1) begin
            cnt <= 0;
        end
        else begin
            cnt <= cnt + 1;
        end
    end
end

assign trig = cnt == SIZE - 1 ? 1 : 0;

endmodule
