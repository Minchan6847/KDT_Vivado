`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/01/09 14:58:36
// Design Name: 
// Module Name: calculator_tb
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


module calculator_tb();

reg clk = 0, rst = 0;
reg [4:0] keypad_pulse = 0;
wire [3:0] q1, q2;
calculator DUT(clk, rst, keypad_pulse, q1, q2);

always begin
    #5; // 100MHz, Period: 10ns
    clk = ~clk; 
end

initial begin
    #100 rst = 1;
    #100 rst = 0;
    
    #6
    #100 keypad_pulse = 5'h11;
    #10  keypad_pulse = 5'h0;
    
    #100 keypad_pulse = 5'h12;
    #10  keypad_pulse = 5'h0;
    
    #100
    $stop;
end

endmodule
