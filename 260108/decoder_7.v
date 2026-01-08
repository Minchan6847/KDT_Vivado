`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/01/08 13:06:12
// Design Name: 
// Module Name: decoder_7
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


module decoder_7(
input [3:0] q,
output reg [6:0] dec_q
);

always @(*) begin
    case(q)
        0: dec_q = 7'b111_1110;
        1: dec_q = 7'b011_0000;
        2: dec_q = 7'b110_1101;
        3: dec_q = 7'b111_1001;
        4: dec_q = 7'b011_0011;
        5: dec_q = 7'b101_1011;
        6: dec_q = 7'b101_1111;
        7: dec_q = 7'b111_0010;
        8: dec_q = 7'b111_1111;
        9: dec_q = 7'b111_1011;
        default: dec_q = 7'b000_0000;
    endcase
end

endmodule
