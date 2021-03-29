`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/17/2021 03:46:01 PM
// Design Name: 
// Module Name: test_state
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


module test_state();
    reg clock;
    reg left;
    reg right;
    wire timer;
    wire reset;
    wire inc;
    wire dec;
    wire [6:0] test;
    wire [6:0] test_s;
    
    state_Machine UUT(.clock(clock), .right(right), .left(left), .test(test), .test_s(test_s),
         .timer(timer), .reset(reset), .inc(inc), .dec(dec));
    
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
    right = 1'b0;
    left = 1'b0;
    #100
    //left and then leave
    left = 1'b1;
    #100
    left = 1'b0;
    
    #100
    //left then both, then leave left
    left = 1'b1;
    #100
    right = 1'b1;
    #100
    right = 1'b0;
    #100
    left = 1'b0;  
    #100
    
    //right and then leave
    right = 1'b1;
    #100
    right = 1'b0;
    
    #100
    //right then both, then leave right
    right = 1'b1;
    #100
    left = 1'b1;
    #100
    left = 1'b0;
    #100
    right = 1'b0;  
    #100
    
    //left then both, the leave right: dec
    left = 1'b1;
    #100
    right = 1'b1;
    #100
    left = 1'b0;
    #100
    right = 1'b0;
    
    //right then both, the leave left (inc)
    right = 1'b1;
    #100
    left = 1'b1;
    #100
    right = 1'b0;
    #100
    left = 1'b0;
    
    end
endmodule