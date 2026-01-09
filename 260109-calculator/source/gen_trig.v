`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/01/08 15:50:36
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


module gen_trig(input clk_6mhz, rst, output trig);
parameter SIZE = 6000000;
    
reg [31:0] count; 
always @(posedge clk_6mhz, posedge rst) begin
    if (rst) count <=0; 
    else if (count == SIZE-1) count <=0; 
    else count <= count + 1;
end

assign trig = (count == SIZE-1)? 1 : 0; 

endmodule


