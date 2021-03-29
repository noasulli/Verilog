`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/16/2021 04:38:13 PM
// Design Name: 
// Module Name: syncer
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


module syncer(
    input [2:0] d,
    input clock,
    
    output [2:0] q
    );
    
    FDRE #(.INIT(1'b0) ) sync0 (.C(clock), .CE(1'b1), .R(1'b0), .D(d[0]), .Q(q[0]));
    FDRE #(.INIT(1'b0) ) sync1 (.C(clock), .CE(1'b1), .R(1'b0), .D(d[1]), .Q(q[1]));
    FDRE #(.INIT(1'b0) ) sync2 (.C(clock), .CE(1'b1), .R(1'b0), .D(d[2]), .Q(q[2]));
endmodule