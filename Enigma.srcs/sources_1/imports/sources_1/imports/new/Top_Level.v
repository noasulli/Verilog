`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/25/2021 02:41:40 PM
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
    input btnC,
    input btnR,
    input btnD,
    input sw,
    
    output [6:0] seg,
    output dp,
    output [3:0] an,
    output [15:0] led
    );
    
    wire clk; //clock to be used
    wire dig_sel;
    labEnigma_clks enigma (.clkin(clkin), .greset(btnR), .clk(clk), .digsel(dig_sel));
    
    // crib key for decode
    wire crib; 
    
    wire edge_up, edge_dw;
    
    
    wire advanceCount;
    wire interval;
 
    wire restart;
    wire advance;
    wire [4:0] char;
    wire [19:0] key;
    wire [19:0] key_start;
    wire[4:0] char_out;
    wire[19:0] msg_length;
    
    wire UTC_Out, DTC_Out;
    wire btnC_sync, btnD_sync;
    wire search, stop, chill, reset, continue;
    //detect button signal on clock edge only also makes it so you cant press btnC during crib search
     EdgeDetect e1 (.clock(clk), .digsel(dig_sel), .btn(btnC & ~search), .signal(btnC_sync));
     EdgeDetect e2 (.clock(clk), .digsel(dig_sel), .btn(btnD & ~search), .signal(btnD_sync));
      wire idle0, idle1, done;
    
    // begins at 0 and provides a starting key for the next counter to use, incs when restart is high
    countUD20L outerLoop(.clock(clk), .Up((reset & ~crib & ~stop) & ~done), .LD(btnR | chill), .Din(20'h00000), .Q(key_start), .UTC(UTC_Out), .DTC(DTC_Out), .Dw(1'b0));
    
    // generate character to decode
    queue Queue(.clk(clk), .advance(search & ~done), .restart(continue| chill), .Q(char));
    
    // iterates from the starting key to starting key + 128, in order to decode each key properly
    countUD20L innerLoop(.clock(clk), .Up(search), .LD(continue | chill), .Din(key_start), .Q(key), .Dw(1'b0));
    
    countUD20L msg_length_count(.clock(clk), .Up(search), .LD(continue| chill), .Din(20'h00000), .Q(msg_length), .Dw(1'b0));
    
    //restart goes high when msg_length reaches 128, the length of a single message or btnC is pressed
    // msg_length[6] & msg_length[5] & msg_length[4] & msg_length[3] & msg_length[2] & msg_length[1] & msg_length[0]
    assign restart = ((msg_length[6] & msg_length[5] & msg_length[4] & msg_length[3] & msg_length[2] & msg_length[1] & msg_length[0]) & ~crib) ^ (btnC_sync & ~chill);
    
    scramble eggs(.in(char), .Key(key), .out(char_out)); 
   
    
    Crib_Detect Find(.clock(clk), .restart(restart), .char(char_out), .btnC(btnC_sync ^ (btnD_sync & chill)), .crib_found(crib));
   
    state_machine StateOfAffairs(.idle(idle1 & ~crib & ~stop), .continue(continue), .crib(crib), .restart(restart), .btnC(btnC_sync ^ (btnD_sync & chill)), .clock(clk), .search(search), .stop(stop), .chill(chill), .reset(reset), .done(done));
    
    
    // sets all the sgs to - before search begins
    wire [3:0] ringOut;
    RingCounter ring(.clock(clk), .advance(dig_sel), .out(ringOut));
    
    wire [3:0] seg7in;
    selector segSelect (.sel(ringOut), .N({key_start[18:15], key_start[13:10], key_start[8:5], key_start[3:0]}), .H(seg7in));
    
    
    // send UTC to next clock edge
    
    FDRE #(.INIT(1'b0) ) utc0 (.C(clk), .CE(1'b1), .R(1'b0), .D(UTC_Out), .Q(idle0));
    FDRE #(.INIT(1'b0) ) utc1 (.C(clk), .CE(1'b1), .R(1'b0), .D(idle0), .Q(idle1));
    
    wire [6:0] seg_out;
    hex7seg display (.n(seg7in), .s(seg_out));
    m2_1x8 pos_or_neg (.in0(seg_out), .in1({7'b0111111}), .sel(chill | (done & ~stop & ~crib)), .o(seg[6:0])); 
    
    //since an is active low
    assign an = ~ringOut;
    assign dp = 1'b1;  
    assign led[5] = 1'b0;
    assign led[11] = 1'b0;
    assign led[15] = key_start[19] & ~(done & ~stop & ~crib);
    assign led[14] = key_start[14] & ~(done & ~stop & ~crib);
    assign led[13] = key_start[9] & ~(done & ~stop & ~crib);
    assign led[12] = key_start[4] & ~(done & ~stop & ~crib);
    
    assign led[10] = char_out[4] & ~(done & ~stop & ~crib);
    assign led[9] = char_out[3] & ~(done & ~stop & ~crib);
    assign led[8] = char_out[2] & ~(done & ~stop & ~crib);
    assign led[7] = char_out[1] & ~(done & ~stop & ~crib);
    assign led[6] = char_out[0] & ~(done & ~stop & ~crib);
    
    
    assign led[4] = char[4] & ~(done & ~stop & ~crib);
    assign led[3] = char[3] & ~(done & ~stop & ~crib);
    assign led[2] = char[2] & ~(done & ~stop & ~crib);
    assign led[1] = char[1] & ~(done & ~stop & ~crib);
    assign led[0] = char[0] & ~(done & ~stop & ~crib);
    
endmodule
