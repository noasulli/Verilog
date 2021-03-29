`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/16/2021 01:43:28 PM
// Design Name: 
// Module Name: Turkey_Counter
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


module Turkey_Counter(
    input clock,
    input Up,
    input Dw,
    input LD,
    
    output [7:0] Q,
    output UTC,
    output DTC,
    output neg
    );
    
    wire UTC_0, DTC_0;
    wire UTC_1, DTC_1;
    
    wire [7:0]Q_unsigned;
    wire [7:0]Q_signed;
    countUD4L count_0(.clock(clock), .Up(Up), .Dw(Dw), .LD(LD), .UTC(UTC_0), .DTC(DTC_0), .Q(Q_unsigned[3:0]));
    countUD4L count_1(.clock(clock), .Up(Up & UTC_0), .Dw(Dw & DTC_0), .LD(LD), .UTC(UTC_1), .DTC(DTC_1), .Q(Q_unsigned[7:4]));
    
    assign DTC = DTC_0 & DTC_1;
    
    // Checks if negative
    assign neg = Q_unsigned[7];
    
    // converts from signed to unsigned
    
    
    
        // flips bits
    m2_1x8 Q_sign(.in0(Q_unsigned[7:0]), .in1(~Q_unsigned[7:0]), .sel(neg), .o(Q_signed[7:0]));
    
        // if negative, add 1
    adder_x_8 add_1_Q(.A(Q_signed[7:0]), .B(8'b00000000), .Cin(neg), .S(Q[7:0]));
    
endmodule
