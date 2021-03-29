`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/11/2021 10:31:15 AM
// Design Name: 
// Module Name: stateMachine_test
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


module test_crib();
    reg [4:0]char;
    reg clock;
    reg restart;
   
    wire found;

    
    Crib_Detect UUT(.clock(clock), .char(char), .restart(restart), .crib_found(found));
            
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
    //initial
    restart = 1'b0;
    char = 5'b00000;
    //state 0
    #1000
    char = 5'b00110;
    #400
    char = 5'b01110;
    #400
    char = 5'b11010;
    #400
    char = 5'b10010;
    #400
    char = 5'b01011;
    #400
    char = 5'b10100;
    #400
    char = 5'b00110;
    #400
    char = 5'b10010;
    #400
    char = 5'b11010;
    #400
    restart = 1'b1;
    #400
    restart = 1'b0;
    #400
    char = 5'b00110;
    #400
    char = 5'b01110;
    #400
    char = 5'b11010;
    #400
    char = 5'b10110;
    #400
    char = 5'b01011;
   
    
    end
endmodule

