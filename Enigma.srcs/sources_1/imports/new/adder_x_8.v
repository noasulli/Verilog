`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/20/2021 01:10:39 PM
// Design Name: 
// Module Name: adder_x_8
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


module adder_x_8(
    
    input [7:0] A,
    input [7:0] B,
    input Cin,
    
    output [7:0] S
    );
    
    wire carry[7:0];
    
    FullAdder_mux bit_0 (.e(1'b1), .A(A[0]), .B(B[0]), .Cin(Cin), .S(S[0]), .Cout(carry[0]));
    FullAdder_mux bit_1 (.e(1'b1), .A(A[1]), .B(B[1]), .Cin(carry[0]), .S(S[1]), .Cout(carry[1]));
    FullAdder_mux bit_2 (.e(1'b1), .A(A[2]), .B(B[2]), .Cin(carry[1]), .S(S[2]), .Cout(carry[2]));
    FullAdder_mux bit_3 (.e(1'b1), .A(A[3]), .B(B[3]), .Cin(carry[2]), .S(S[3]), .Cout(carry[3]));
    FullAdder_mux bit_4 (.e(1'b1), .A(A[4]), .B(B[4]), .Cin(carry[3]), .S(S[4]), .Cout(carry[4]));
    FullAdder_mux bit_5 (.e(1'b1), .A(A[5]), .B(B[5]), .Cin(carry[4]), .S(S[5]), .Cout(carry[5]));
    FullAdder_mux bit_6 (.e(1'b1), .A(A[6]), .B(B[6]), .Cin(carry[5]), .S(S[6]), .Cout(carry[6]));
    FullAdder_mux bit_7 (.e(1'b1), .A(A[7]), .B(B[7]), .Cin(carry[6]), .S(S[7]));
    
endmodule
