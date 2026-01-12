`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/01/12 14:50:54
// Design Name: 
// Module Name: multiplier
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


module multiplier(a, b, s);
// Baugh-Wooley Multiplier(WB bit signed)

parameter WB = 8;

input [WB - 1:0] a, b;
output reg [2 * WB - 1: 0] s;

reg [WB - 1: 0] temp [0:WB - 1];
reg [WB - 1: 0] temp2 [0:WB - 1];

integer i;

always @(*) begin
    
    s = 0;
    
    for(i = 0; i <= WB - 1; i = i + 1) begin
        temp[i] = a & {WB{b[i]}};
        
        if(i != WB - 1) begin
            temp2[i] = {~ temp[i][WB - 1], temp[i][WB - 2:0]};
            if(i == 0) begin
                s = s + {1'b1, temp2[i]};
            end
            else begin
                s = s + ({{WB{1'b0}}, temp2[i]} << i);
            end
        end
        else begin // i == WB - 1
            temp2[i] = {temp[i][WB - 1], ~ temp[i][WB - 2:0]};
            s = s + ({{WB{1'b0}}, 1'b1, temp2[i]} << i);
        end
    end
    
end

endmodule


