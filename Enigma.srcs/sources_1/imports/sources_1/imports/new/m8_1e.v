`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/19/2021 10:48:34 AM
// Design Name: 
// Module Name: m4_1e
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

module m8_1e(
    input [7:0] in,
    input [2:0] sel,
    input e,
    
    output o
    );
    //8 to 1 mux
    assign o = e & ((in[0]&~sel[0]&~sel[1]&~sel[2]) | (in[1]&sel[0]&~sel[1]&~sel[2]) | (in[2]&~sel[0]&sel[1]&~sel[2]) | (in[3]&sel[0]&sel[1]&~sel[2]) | (in[4]&~sel[0]&~sel[1]&sel[2]) | (in[5]&sel[0]&~sel[1]&sel[2]) | (in[6]&~sel[0]&sel[1]&sel[2]) | (in[7]&sel[0]&sel[1]&sel[2]));
    
       
endmodule