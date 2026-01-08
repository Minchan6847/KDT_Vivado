`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/01/08 12:43:05
// Design Name: 
// Module Name: top_tb
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


module top_tb(
);

reg clk_125MHz = 0, rst = 0;
reg [2:0] btn = 0;
wire [6:0] ssd;
wire ssdcat;

initial begin
    #200 rst = 1;
    #100 rst = 0;
    /*
    #300 btn[0] = 1;
    #1000 btn[0] = 0;
    #300 btn[1] = 1;
    #1000 btn[1] = 0;
    #300 btn[2] = 1;
    #1000 btn[2] = 0;
    #20 //rst = 1;
    */
    #300 btn[2] = 1;
    #1000 btn[2] = 0;
    
    #32400 //en = 0;
    #30000 btn[2] = 1;
    #1000 btn[2] = 0;
    #5000 btn[0] = 1;
    #1000 btn[0] = 0;
    #30000
    
    #40
    $stop;
end

always begin
    #4 clk_125MHz = ~ clk_125MHz;
end

top DUT(clk_125MHz, rst, btn, ssd, ssdcat);

endmodule



