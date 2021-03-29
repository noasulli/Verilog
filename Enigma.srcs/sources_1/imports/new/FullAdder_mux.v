`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/19/2021 11:22:58 AM
// Design Name: 
// Module Name: FullAdder_mux
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


module FullAdder_mux(
    input A,
    input B,
    input Cin,
    input e,
    
    output S,
    output Cout
    );
    
    assign e = 1'b1;
    
    //sum
    m4_1e add1(.e(e), .in({Cin, ~Cin, ~Cin, Cin}), .sel({A, B}), .o(S));
    //carry bit
    m4_1e add2(.e(e), .in({1'b1, Cin, Cin, 1'b0}), .sel({A, B}), .o(Cout));
endmodule
