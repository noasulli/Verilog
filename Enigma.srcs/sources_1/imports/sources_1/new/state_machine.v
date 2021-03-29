`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/01/2021 12:41:33 PM
// Design Name: 
// Module Name: state_machine
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


module state_machine(
    input crib,
    input btnC,
    input clock,
    input restart,
    input idle,
    
    output search,
    output stop,
    output chill,
    output reset,
    output continue,
    output done
    );
    
    
 wire [5:0] s;
 wire [5:0] d;
 FDRE #(.INIT(1'b1) ) state0 (.C(clock), .CE(1'b1), .R(1'b0), .D(d[0]), .Q(s[0]));
 FDRE #(.INIT(1'b0) ) state1 (.C(clock), .CE(1'b1), .R(1'b0), .D(d[1]), .Q(s[1]));
 FDRE #(.INIT(1'b0) ) state2 (.C(clock), .CE(1'b1), .R(1'b0), .D(d[2]), .Q(s[2]));
 FDRE #(.INIT(1'b0) ) state3 (.C(clock), .CE(1'b1), .R(1'b0), .D(d[3]), .Q(s[3]));
 FDRE #(.INIT(1'b0) ) state4 (.C(clock), .CE(1'b1), .R(1'b0), .D(d[4]), .Q(s[4]));
 FDRE #(.INIT(1'b0) ) state5 (.C(clock), .CE(1'b1), .R(1'b0), .D(d[5]), .Q(s[5]));
 // begin state
 assign d[0] = (s[0] & ~btnC);
 // Searching For Crib
 assign d[1] = (s[0] & btnC) | (s[1] & ~crib) | (s[2] & btnC) | (s[4]) | (s[2] & ~crib);
 // Found Crib
 assign d[2] = ((s[1] & crib) | (s[2] & ~btnC));
 // chill state
 assign d[3] = restart;
 assign d[4] = reset;
 assign d[5] = idle | s[5];
 
 
 


 // assign outputs for state machine
 assign stop = s[2];
 assign search = s[1];
 assign chill = s[0];
 assign reset = s[3];
 assign continue = s[4];
 assign done = s[5];
endmodule
