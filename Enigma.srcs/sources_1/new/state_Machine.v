`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/16/2021 02:20:34 PM
// Design Name: 
// Module Name: state_Machine
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


module state_Machine(
    input left,
    input right,
    input clock,
 
    output timer,
    output reset, //reset timer
    output inc,
    output dec,
    
    output [6:0] test,
    output [6:0] test_s
    );
    
    wire [6:0] s;
    wire [6:0] d;
    FDRE #(.INIT(1'b1) ) state0 (.C(clock), .CE(1'b1), .R(1'b0), .D(d[0]), .Q(s[0]));
    FDRE #(.INIT(1'b0) ) state1 (.C(clock), .CE(1'b1), .R(1'b0), .D(d[1]), .Q(s[1]));
    FDRE #(.INIT(1'b0) ) state2 (.C(clock), .CE(1'b1), .R(1'b0), .D(d[2]), .Q(s[2]));
    FDRE #(.INIT(1'b0) ) state3 (.C(clock), .CE(1'b1), .R(1'b0), .D(d[3]), .Q(s[3]));
    FDRE #(.INIT(1'b0) ) state4 (.C(clock), .CE(1'b1), .R(1'b0), .D(d[4]), .Q(s[4]));
    FDRE #(.INIT(1'b0) ) state5 (.C(clock), .CE(1'b1), .R(1'b0), .D(d[5]), .Q(s[5]));
    FDRE #(.INIT(1'b0) ) state6 (.C(clock), .CE(1'b1), .R(1'b0), .D(d[6]), .Q(s[6]));
    
    
    // No turkeys
    assign d[0] = (s[4] & ~right) | ((s[6] | s[5]) & (~left & ~right))
                    | (s[1] & ~left) | (s[3] & ~right) | (s[2] & ~left) | (s[0] & ~(left | right));
    // Going right 
   assign d[1] = (s[0] & left) | (s[6] & ~right) | (s[1] & left & ~right);
    // Going left: in left
    assign d[2] = (s[5] & ~right) | (s[2] & left & ~right);
    // Going Left
    assign d[3] = (s[0] & right) | (s[3] & right & ~left) | (s[5] & ~left);
    // Going Right: in right
    assign d[4] = (s[6] & ~left) | (s[4] & right & ~left);
    // In Both from left
    assign d[5] =  (s[2] & right) | (s[5] & left & right) | (s[3] & left);
    // In Both from right
    assign d[6] =  (s[1] & right) | (s[6] & left & right) | (s[4] & left);
    
    
    // trigger timer reset
    assign reset = (s[4] & ~right) | (s[2] & ~left) | (s[6] & ~right) | (s[0] & right) | (s[5] & ~left)
                    | (s[1] & right) | (s[4] & left) | (s[3] & left) | (s[2] & right) | (s[6] & ~left) 
                    | (s[5] & ~right) | (s[3] & ~right) | (s[1] & ~left) | (s[0] & left);
    
    // inc for time
    assign timer = ~s[0];
    
    assign inc = s[2] & ~left;
    assign dec = s[4] & ~right;
    
    
    assign test[6:0] = d[6:0];
    assign test_s[6:0] = s[6:0];
    
endmodule
