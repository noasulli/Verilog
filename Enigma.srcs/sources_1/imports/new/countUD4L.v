`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/25/2021 12:17:20 PM
// Design Name: 
// Module Name: countUD5L
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


module countUD4L(
    input clock,
    input Up,
    input Dw,
    input LD,
    input [3:0] Din,
    
    output [3:0] Q,
    output UTC,
    output DTC
    
    );
    
    //utc is high if counterbits are all 1
    assign UTC = Q[3] & Q[2] & Q[1] & Q[0];
    //dtc is high if counterbits are all 0
    assign DTC = ~Q[3] & ~Q[2] & ~Q[1] & ~Q[0];
    
    wire ce;
    wire u0, u1, u2, u3;
    wire d1, d2, d3;
    
    assign ce = (Up ^ Dw) | LD;
    //up count
    assign u0 = (Q[0] ^ ce);
    assign u1 = Q[1] ^ (ce & Q[0]);
    assign u2 = Q[2] ^ (ce & Q[1] & Q[0]);
    assign u3 = Q[3] ^ (ce & Q[2] & Q[1] & Q[0]);
    
    //down count
    assign d1 = Q[1] ^ (ce & ~Q[0]);
    assign d2 = Q[2] ^ (ce & ~Q[1] & ~Q[0]);
    assign d3 = Q[3] ^ (ce & ~Q[2] & ~Q[1] & ~Q[0]);
    
    wire [3:0] out;
    assign out[3] = ((((u3 & Up & ~Dw) | (d3 & ~Up & Dw)) & ~LD) | (LD & Din[3]));
    assign out[2] = ((((u2 & Up & ~Dw) | (d2 & ~Up & Dw)) & ~LD) | (LD & Din[2]));
    assign out[1] = ((((u1 & Up & ~Dw) | (d1 & ~Up & Dw)) & ~LD) | (LD & Din[1]));
    assign out[0] = ((((u0 & Up & ~Dw) | (u0 & ~Up & Dw)) & ~LD) | (LD & Din[0]));
    
    
    FDRE #(.INIT(1'b0) ) flip3 (.C(clock), .R(1'b0), .CE(ce), .D(out[3]), .Q(Q[3]));
    FDRE #(.INIT(1'b0) ) flip2 (.C(clock), .R(1'b0), .CE(ce), .D(out[2]), .Q(Q[2]));
    FDRE #(.INIT(1'b0) ) flip1 (.C(clock), .R(1'b0), .CE(ce), .D(out[1]), .Q(Q[1]));
    FDRE #(.INIT(1'b0) ) flip0 (.C(clock), .R(1'b0), .CE(ce), .D(out[0]), .Q(Q[0]));
endmodule
