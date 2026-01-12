`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/01/12 14:10:08
// Design Name: 
// Module Name: fir8_tb
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


module fir8_tb();

reg clk = 0, rst = 0, cwe = 0;
reg [7:0] coef;
reg [7:0] din;
wire signed [18:0] dout;

fir8 #(.WB(8), .C_WB(8)) DUT(clk, rst, cwe, coef, din, dout);

// 순서
// 1번 rst 켰다가 끄기
// 2번 coef 읽기
// 3번 din 읽기 


// -------------- 1. clk, rst 만들기 (initial) -------------- //
always begin
    #5; // 100MHz, Period: 10ns
    clk = ~clk;
end

initial begin
    #10 rst = 1;
    #20 rst = 0;
end

// -------------- 2. cwe와 coef 만들기 -------------- //
// cwe를 만든 다음에, coef를 file에서 불러오기 (coef.txt)
integer cfid;
// read the data from file
initial begin
    cwe = 1;
    #100
    
    cfid = $fopen("coef.txt", "r");
    while (!$feof(cfid)) begin
        @(posedge clk) begin
            if (rst)
                coef <= 0;
            else begin
                $fscanf(cfid, "%d\n", coef);
            end
        end
    end
    #5 cwe = 0;

    $fclose(cfid); 
    #100;
    
end
    
// -------------- 3. din 읽고 dout 쓰기 -------------- //
integer rfid, wfid;
// read the data from file
initial begin
    #1000
    rfid = $fopen("din.txt", "r");    
    wfid = $fopen("dout.txt", "w");
    
    while (!$feof(rfid)) begin
        @(posedge clk) begin
            if (rst)
                din <= 0;
            else begin
                $fscanf(rfid, "%d\n", din);
                $fwrite(wfid, "%d\n", dout);
           end
        end
    end

    $fclose(rfid);
    $fclose(wfid);
    #3000
    $stop;
end

endmodule



