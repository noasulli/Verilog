`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/25/2021 04:14:15 PM
// Design Name: 
// Module Name: edgeDetector
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


module EdgeDetect(
    input btn,
    input clock,
    input digsel,
    //input ce, //always running
    
    output signal

    );
    

    wire q0, q1;

    //if button C is pressed, q0 -> 1, and then q1 -> 1;
    FDRE #(.INIT(1'b0) ) edge1 (.CE(1'b1), .C(clock), .R(), .D(btn), .Q(q0));
    FDRE #(.INIT(1'b0) ) edge2 (.CE(1'b1), .C(clock), .R(), .D(q0), .Q(q1));

    assign signal = btn & ~q0 & ~q1;
    
endmodule
