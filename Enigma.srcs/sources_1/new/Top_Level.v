`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/16/2021 02:49:29 PM
// Design Name: 
// Module Name: Top_Level
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


module Top_Level(
    input clkin,
    input btnL,
    input btnR,
    input btnD,
    
    output led15,
    output led8,
    output dp,
    output [3:0] an,
    output [6:0] seg
    );
    
    // global clock
    wire clock, qsec, digsel, speed;
    lab6_clks Clock (.clkin(clkin), .greset(btnSync[0]), .clk(clock), .digsel(digsel), .qsec(qsec));
    
    // qsecs
    wire [3:0] Q_ring;
    RingCounter quarter (.clock(clock), .advance(qsec), .out(Q_ring));
    
    // sync bootons
    wire [2:0] btnSync;
    syncer sync (.d({btnL, btnR, btnD}), .clock(clock), .q(btnSync));
    
    
    // run the state machine
    wire timer, reset, inc, dec;
    state_Machine divided_states (.left(btnSync[2]), .right(btnSync[1]), 
    .clock(clock), .timer(timer), .reset(reset), .inc(inc), .dec(dec));
    
    //count them turkeys (gobble)
    wire neg;
    wire [7:0] turkey_num;
    Turkey_Counter turkeyCount (.clock(clock), .Up(inc), .Dw(dec), .LD(1'b0), .Q(turkey_num), .neg(neg));
    
    
    // IT IS TIME NOW
    wire [3:0] time_out;
    countUD4L timecount (.clock(clock), .Up(qsec & Q_ring[2] & ~time_out[2] & timer), .Dw(1'b0), .LD(reset & timer), .Din(4'h0), .Q(time_out));
    
    // Do I show the time?
    wire time_show;
    assign time_show = (timer & ~time_out[2]) | (timer & time_out[2] & (Q_ring[1] | Q_ring[2]));
    
    //7seg logic
    wire [3:0] ring_out;
    RingCounter anode (.clock(clock), .advance(digsel), .out(ring_out));
    wire [3:0] select_out;
    selector select (.sel({ring_out[3], 1'b0, ring_out[1], ring_out[0]}), .N({time_out, 4'h0, turkey_num}), .H(select_out));
    
    wire [6:0] seg_out;
    hex7seg segs (.n(select_out), .s(seg_out));
    // choose if pos or neg
    m2_1x8 pos_or_neg (.in0(seg_out), .in1({7'b0111111}), .sel(neg & ring_out[2]), .o(seg[6:0])); 
    
    
    assign an[0] = ~(ring_out[0]);
    assign an[1] = ~(ring_out[1]);
    assign an[2] = ~(ring_out[2] & neg);
    assign an[3] = ~(ring_out[3] & time_show);
    
    
    assign dp = 1'b1;
    
    // LEDS
    assign led8 = ~btnSync[1];
    assign led15 = ~btnSync[2];
endmodule
