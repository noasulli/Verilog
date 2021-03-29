`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/18/2021 12:59:33 PM
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
    reg btnL;
    reg btnR;
    reg btnD;
    
    wire led15;
    wire led8;
    wire dp;
    wire [3:0] an;
    wire [6:0] seg;

    
    Top_Level UUT(.clkin(clock), .btnL(btnL), .btnR(btnR), .btnD(btnD),
         .led15(led15), .led8(led8), .dp(dp), .an(an), .seg(seg));
    
    parameter PERIOD = 20;
    parameter real DUTY_CYCLE = 0.5;
    parameter OFFSET = 2;

    initial    
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
    btnR = 1'b0;
    btnL = 1'b0;
    btnD = 1'b0;
    #1200
    //left and then leave
    btnL = 1'b1;
    #500
    btnL = 1'b0;
    
    #500
    //left then both, then leave left
    btnL = 1'b1;
    #500
    btnR = 1'b1;
    #500
    btnR = 1'b0;
    #500
    btnL = 1'b0;  
    #500
    
    //right and then leave
    btnR = 1'b1;
    #500
    btnR = 1'b0;
    
    #500
    //right then both, then leave right
    btnR = 1'b1;
    #500
    btnL = 1'b1;
    #500
    btnL = 1'b0;
    #500
    btnR = 1'b0;  
    #500
    
    //left then both, the leave right: dec
    btnL = 1'b1;
    #500
    btnR = 1'b1;
    #500
    btnL = 1'b0;
    #500
    btnR = 1'b0;
    
    //right then both, the leave left (inc)
    btnR = 1'b1;
    #500
    btnL = 1'b1;
    #500
    btnR = 1'b0;
    #500
    btnL = 1'b0;
    
    // reset 
    
    #500
    btnD = 1'b1;
    #500
    btnD =1'b0;
    
    end
endmodule
