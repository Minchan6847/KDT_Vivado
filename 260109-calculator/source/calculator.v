`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/01/09 10:14:55
// Design Name: 
// Module Name: calculator
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


module calculator(input clk, rst, input [4:0] keypad_pulse, output reg [3:0] q1, q2);

//----------------- STEP 1 - state parameter -----------------//
parameter SR = 0, SA = 1, SB = 2, SC = 3;
parameter NONE = 0, PLUS = 1, MINUS = 2, MULTI = 3;

reg [1:0] c_state, n_state, operator;
reg [3:0] a1, a2, b1, b2, s1, s2;

//----------------- STEP 2 - n_state -----------------//
always @(*) begin
    case(c_state)
        SR: n_state = SA;
        SA: n_state = (keypad_pulse[4:0] == 5'h1A || keypad_pulse[4:0] == 5'h1B || keypad_pulse[4:0] == 5'h1C) ? SB : (keypad_pulse[4:0] == 5'h1F ? SR : SA);
        SB: n_state = (keypad_pulse[4:0] == 5'h1D) ? SC : (keypad_pulse[4:0] == 5'h1F ? SR : SB);
        SC: n_state = (keypad_pulse[4:0] == 5'h1F) ? SR : SC;
        default:n_state = SR;
    endcase
end

//----------------- STEP 3 - c_state -----------------//
always @(posedge clk or posedge rst) begin
    if(rst) begin
        c_state <= SR;
    end
    else begin
        c_state <= n_state;
    end
end

//----------------- a1, a2, operator -----------------//
always @(posedge clk or posedge rst) begin
    if(rst || c_state == SR) begin
        a1 <= 4'h0;
        a2 <= 4'h0;
        operator <= NONE;
    end
    else if(keypad_pulse[4] && c_state == SA) begin
        if(keypad_pulse[3:0] >= 4'h0 && keypad_pulse[3:0] <= 4'h9) begin
            a1 <= keypad_pulse[3:0];
            a2 <= a1;
        end
        else begin
            case(keypad_pulse[3:0])
                4'hA: operator <= PLUS;
                4'hB: operator <= MINUS;
                4'hC: operator <= MULTI;
                default: operator <= NONE;
            endcase
        end
    end
end

//----------------- b1, b2 -----------------//
always @(posedge clk or posedge rst) begin
    if(rst || c_state == SR) begin
        b1 <= 4'h0;
        b2 <= 4'h0;
    end
    else if(keypad_pulse[4] && c_state == SB)begin
        if(keypad_pulse[3:0] >= 4'h0 && keypad_pulse[3:0] <= 4'h9) begin
            b1 <= keypad_pulse[3:0];
            b2 <= b1;
        end
    end
end

//----------------- s1, s2 -----------------//
always @(posedge clk or posedge rst) begin
    if(rst || c_state == SR) begin
        s1 <= 4'h0;
        s2 <= 4'h0;
    end
    else if(c_state == SC) begin
        case(operator)
            PLUS: begin
                s1 <= ((a2 * 10 + a1) + (b2 * 10 + b1)) % 10;
                s2 <= ((a2 * 10 + a1) + (b2 * 10 + b1)) / 10;
            end
            MINUS: begin
                if((a2 * 10 + a1) >= (b2 * 10 + b1)) begin
                    s1 <= ((a2 * 10 + a1) - (b2 * 10 + b1)) % 10;
                    s2 <= ((a2 * 10 + a1) - (b2 * 10 + b1)) / 10;
                end
                else begin // 음수이면
                    s1 <= (~ ((a2 * 10 + a1) - (b2 * 10 + b1)) + 1) % 10;
                    s2 <= (~ ((a2 * 10 + a1) - (b2 * 10 + b1)) + 1) / 10;
                end
            end
            MULTI: begin
                s1 <= ((a2 * 10 + a1) * (b2 * 10 + b1)) % 10;
                s2 <= ((a2 * 10 + a1) * (b2 * 10 + b1)) / 10;
            end
            default: begin
                s1 <= 4'h0;
                s2 <= 4'h0;
            end
        endcase
    end
end

//----------------- Output - q1, q2 -----------------//
always @(*) begin
    case(c_state)
        SR: begin
            q1 = 4'h0;
            q2 = 4'h0;
        end
        SA: begin
            if(a2 == 0 && a1 == 0) begin
                q1 = 4'hA;
                q2 = 4'hA;
            end
            else if(a2 == 0 && a1 != 0) begin
                q1 = a1;
                q2 = 4'hA;
            end
            else begin
                q1 = a1;
                q2 = a2;
            end
        end
        SB: begin
            if(b2 == 0 && b1 == 0) begin
                q1 = 4'hA;
                q2 = 4'hA;
            end
            else if(b2 == 0 && b1 != 0) begin
                q1 = b1;
                q2 = 4'hA;
            end
            else begin
                q1 = b1;
                q2 = b2;
            end
        end
        SC: begin
            if(s2 == 0 && s1 != 0) begin
                q1 = s1;
                q2 = 4'hA;
            end
            else begin
                q1 = s1;
                q2 = s2;
            end
        end
        default: begin
            q1 = 4'h0;
            q2 = 4'h0;
        end
    endcase
end

ila_0 ila_inst(
clk,
a1,
a2,
keypad_pulse,
c_state,
n_state
);

endmodule



