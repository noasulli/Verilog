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


module m4_1e(
    input e,
    input [3:0] in,
    input [1:0] sel,
    
    output o
    );
    
    //4-1 mux
    assign o = e & ((in[0] & ~sel[0] & ~sel[1]) | (in[1] & ~sel[0] & sel[1]) | (in[2] & sel[0] & ~sel[1]) | (in[3] & sel[0] & sel [1]));
    
    
endmodule
