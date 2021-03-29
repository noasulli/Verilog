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


module test_state();
    reg crib;
    reg btnC;
    reg clock;
    reg restart;
    
    wire search;
    wire stop;

    
    state_machine UUT(.clock(clock), .btnC(btnC), .crib(crib), .restart(restart), .search(search), .stop(stop));
            
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
    btnC = 1'b0;
    crib = 1'b0;
    //state 0
    #1000
    btnC = 1'b1;
    #100
    btnC = 1'b0;
    #500
    crib = 1'b1;
    #500
    restart = 1'b1;
   
    
    end
endmodule
