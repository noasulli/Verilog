`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/01/2021 11:39:22 AM
// Design Name: 
// Module Name: Crib_Detect
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


module Crib_Detect(
    input [4:0]char,
    input clock,
    input restart,
    input btnC,
    
    output crib_found
    );
    
 // Create the crib for compare
 wire G, O, space, S, L, U;
 wire[8:0]d;
 wire[8:0]s;
 
 // Flip flops for states
 FDRE #(.INIT(1'b1) ) state0 (.C(clock), .CE(1'b1), .R(1'b0), .D(d[0]), .Q(s[0]));
 FDRE #(.INIT(1'b0) ) state1 (.C(clock), .CE(1'b1), .R(1'b0), .D(d[1]), .Q(s[1]));
 FDRE #(.INIT(1'b0) ) state2 (.C(clock), .CE(1'b1), .R(1'b0), .D(d[2]), .Q(s[2]));
 FDRE #(.INIT(1'b0) ) state3 (.C(clock), .CE(1'b1), .R(1'b0), .D(d[3]), .Q(s[3]));
 FDRE #(.INIT(1'b0) ) state4 (.C(clock), .CE(1'b1), .R(1'b0), .D(d[4]), .Q(s[4]));
 FDRE #(.INIT(1'b0) ) state5 (.C(clock), .CE(1'b1), .R(1'b0), .D(d[5]), .Q(s[5]));
 FDRE #(.INIT(1'b0) ) state6 (.C(clock), .CE(1'b1), .R(1'b0), .D(d[6]), .Q(s[6]));
 FDRE #(.INIT(1'b0) ) state7 (.C(clock), .CE(1'b1), .R(1'b0), .D(d[7]), .Q(s[7]));
 FDRE #(.INIT(1'b0) ) state8 (.C(clock), .CE(1'b1), .R(1'b0), .D(d[8]), .Q(s[8]));
 
 
 assign G = ~char[4] & ~char[3] & char[2] & char[1] & ~char[0];
 assign O = ~char[4] & char[3] & char[2] & char[1] & ~char[0];
 assign space = char[4] & char[3] & ~char[2] & char[1] & ~char[0];
 assign S = char[4] & ~char[3] & ~char[2] & char[1] & ~char[0];
 assign L = ~char[4] & char[3] & ~char[2] & char[1] & char[0];
 assign U = char[4] & ~char[3] & char[2] & ~char[1] & ~char[0];


 // Logic equations for states
 // chill state
 assign d[0] = restart | (s[1] & ~G & ~O) | (s[2] & ~O & ~space) | (s[3] & ~space & ~S) | (s[4] & ~S & ~L)
 | (s[5] & ~L & ~U) | (s[6] & ~U & ~G) | (s[7] & ~G & ~S) | (s[0] & ~G); 
 // Detect "G"
 assign d[1] = (s[0] & G) | (s[1] & G);
 // Detect "GO"
 assign d[2] = (s[1] & O) | (s[2] & O);
 // Detect "GO "
 assign d[3] = (s[2] & space) | (s[3] & space);
 // Detect "GO S"
 assign d[4] = (s[3] & S) | (s[4] & S);
 // Detect "GO SL"
 assign d[5] = (s[4] & L) | (s[5] & L);
 // Detect "GO SLU"
 assign d[6] = (s[5] & U) | (s[6] & U);
  // Detect "GO SLUG"
 assign d[7] = (s[6] & G) | (s[7] & G);
  // Detect "GO SLUGS"
 assign d[8] = ((s[7] & S) | (s[8] & ~restart)) & ~s[0];


 // FOUND CRIB
assign crib_found = s[8];

endmodule