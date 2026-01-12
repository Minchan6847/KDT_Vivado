`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/01/12 15:26:18
// Design Name: 
// Module Name: multiplier_tb
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


module multiplier_tb();

parameter WB = 8;

reg [WB - 1:0] a, b;
wire [2 * WB - 1: 0] s;

multiplier #(.WB(WB)) DUT(a, b, s);

initial begin
    #100 a = 8'b1111_1010; b = 8'b1111_1101; // -6 * -3 = 18(1_0010)
    #100 a = 8'b0000_0010; b = 4'b0000_0001; // 2*1 = 2(0010)
    #100 a = 8'b0000_0010; b = 4'b0000_0010; // 2*2 = 4(0100) 
    #100
    $stop;
end

endmodule


