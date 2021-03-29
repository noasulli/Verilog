`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/02/2021 12:43:11 PM
// Design Name: 
// Module Name: test_top
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


module test_top();

    reg clock;
    reg btnC;
    reg btnR;
    reg btnD;
    reg sw;
    
    wire [6:0] seg;
    wire dp;
    wire [3:0] an;
    wire [15:0] led;
    
    Top_Level UUT(.clkin(clock), .btnC(btnC), .btnR(btnR), .sw(sw), .btnD(btnD), .seg(seg), .dp(dp), .an(an), .led(led));
            
    parameter PERIOD = 20;
    parameter real DUTY_CYCLE = 0.5;
    parameter OFFSET = 2;

    initial    // Clock process for clkin
    begin
        #OFFSET
		  clock = 1'b1;
        forever
        begin
            #(PERIOD-(PERIOD*DUTY_CYCLE)) clock = ~clock;
        end
    end
    
    initial
    begin
    btnC = 1'b0;
    btnR = 1'b0;
    btnD = 1'b0;
    sw = 1'b0;
    #2000
    #500
    btnC = 1'b1;
    #100
    btnC = 1'b0;
    #8500
    btnC = 1'b1;
    #100
    btnC = 1'b0;
    
    end
endmodule
