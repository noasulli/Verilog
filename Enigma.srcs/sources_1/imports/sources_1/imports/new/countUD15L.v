`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/25/2021 12:35:42 PM
// Design Name: 
// Module Name: countUD15L
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


module countUD20L(
    input clock,
    input Up,
    input Dw,
    input LD,
    input [19:0] Din,
    
    output [19:0] Q,
    output UTC,
    output DTC
    );
    wire UTC_0, UTC_1, UTC_2, UTC_3;
    wire DTC_0, DTC_1, DTC_2, DTC_3;
    
    
    
    countUD5L count_0(.clock(clock), .Up(Up), .Dw(Dw), .LD(LD), .Din(Din[4:0]), .UTC(UTC_0), .DTC(DTC_0), .Q(Q[4:0]));
    countUD5L count_1(.clock(clock), .Up(Up & UTC_0), .Dw(Dw & DTC_0), .LD(LD), .Din(Din[9:5]), .UTC(UTC_1), .DTC(DTC_1), .Q(Q[9:5]));
    countUD5L count_2(.clock(clock), .Up(Up & UTC_0 & UTC_1), .Dw(Dw & DTC_0 & DTC_1), .LD(LD), .Din(Din[14:10]), .UTC(UTC_2), .DTC(DTC_2), .Q(Q[14:10]));
    countUD5L count_3(.clock(clock), .Up(Up & UTC_0 & UTC_1 & UTC_2), .Dw(Dw & DTC_0 & DTC_1 & DTC_2), .LD(LD), .Din(Din[19:15]), .UTC(UTC_3), .DTC(DTC_3), .Q(Q[19:15]));
    
    
    assign UTC = UTC_0 & UTC_1 & UTC_2 & UTC_3;
    assign DTC = DTC_0 & DTC_1 & DTC_2 & DTC_3;
    
    
endmodule
