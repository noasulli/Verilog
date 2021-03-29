`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/14/2021 05:07:35 PM
// Design Name: 
// Module Name: scramble
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


module scramble(
    input [4:0] in,
    input [19:0] Key, // S1, S2, S3, S4,
    output [4:0] out
    );
  wire [4:0] B1, B2, B3, B4, B5, B6, B7, B8, B9;
  wire [4:0] S1, S2, S3, S4;
  
  assign S1 = Key[4:0];
  assign S2 = Key[9:5];
  assign S3 = Key[14:10];
  assign S4 = Key[19:15];
  
  RotorR1 R1_f (.in(in+S1),.out(B1));  
  RotorR2 R2_f (.in(B1+S2),.out(B2)); 
  RotorR3 R3_f (.in(B2+S3),.out(B3)); 
  RotorR4 R4_f (.in(B3+S4),.out(B4)); 
  RotorRF RF_f (.in(B4),.out(B5)); 
  RotorR4inv R4inv_f (.in(B5),.out(B6)); 
  RotorR3inv R3inv_f (.in(B6-S4),.out(B7)); 
  RotorR2inv R2inv_f (.in(B7-S3),.out(B8)); 
  RotorR1inv R1inv_f (.in(B8-S2),.out(B9)); 
  
  assign out = B9-S1;
  
endmodule
 
module RotorR1(
   input [4:0] in,
   output [4:0] out);
      
//Rotor  .TDIOFRJ>VM$AZHQNB@XPY,KC ULGSWE
//Hex block B4 :  666CAB43
//Hex block B3 :  0AF52D99
//Hex block B2 :  D45D4F30
//Hex block B1 :  7B9C4817
//Hex block B0 :  081B6BE7

LUT5 #(.INIT(32'h666CAB43)) R1_B4 (.I0(in[0]),.I1(in[1]),.I2(in[2]),.I3(in[3]),.I4(in[4]),.O(out[4]));
LUT5 #(.INIT(32'h0AF52D99)) R1_B3 (.I0(in[0]),.I1(in[1]),.I2(in[2]),.I3(in[3]),.I4(in[4]),.O(out[3]));
LUT5 #(.INIT(32'hD45D4F30)) R1_B2 (.I0(in[0]),.I1(in[1]),.I2(in[2]),.I3(in[3]),.I4(in[4]),.O(out[2]));
LUT5 #(.INIT(32'h7B9C4817)) R1_B1 (.I0(in[0]),.I1(in[1]),.I2(in[2]),.I3(in[3]),.I4(in[4]),.O(out[1]));
LUT5 #(.INIT(32'h081B6BE7)) R1_B0 (.I0(in[0]),.I1(in[1]),.I2(in[2]),.I3(in[3]),.I4(in[4]),.O(out[0]));
endmodule
 
module RotorR1inv(
   input [4:0] in,
   output [4:0] out);
      
//Rotor  .TDIOFRJ>VM$AZHQNB@XPY,KC ULGSWE
//Hex block B4 :  55D4AC56
//Hex block B3 :  A67518D5
//Hex block B2 :  1347C6F1
//Hex block B1 :  D0D31F98
//Hex block B0 :  87AD0F32
LUT5 #(.INIT(32'h55D4AC56)) R1inv_B4 (.I0(in[0]),.I1(in[1]),.I2(in[2]),.I3(in[3]),.I4(in[4]),.O(out[4]));
LUT5 #(.INIT(32'hA67518D5)) R1inv_B3 (.I0(in[0]),.I1(in[1]),.I2(in[2]),.I3(in[3]),.I4(in[4]),.O(out[3]));
LUT5 #(.INIT(32'h1347C6F1)) R1inv_B2 (.I0(in[0]),.I1(in[1]),.I2(in[2]),.I3(in[3]),.I4(in[4]),.O(out[2]));
LUT5 #(.INIT(32'hD0D31F98)) R1inv_B1 (.I0(in[0]),.I1(in[1]),.I2(in[2]),.I3(in[3]),.I4(in[4]),.O(out[1]));
LUT5 #(.INIT(32'h87AD0F32)) R1inv_B0 (.I0(in[0]),.I1(in[1]),.I2(in[2]),.I3(in[3]),.I4(in[4]),.O(out[0]));

endmodule
 
module RotorR2(
   input [4:0] in,
   output [4:0] out);
      
//Rotor  GTZQ.FY >EWP@IA$LOXRJBN,UKCHVSMD
//Hex block B4 :  318C95DE
//Hex block B3 :  42D3B9D4
//Hex block B2 :  59C69F21
//Hex block B1 :  AE079C93
//Hex block B0 :  987D8936
LUT5 #(.INIT(32'h318C95DE)) R2_B4 (.I0(in[0]),.I1(in[1]),.I2(in[2]),.I3(in[3]),.I4(in[4]),.O(out[4]));
LUT5 #(.INIT(32'h42D3B9D4)) R2_B3 (.I0(in[0]),.I1(in[1]),.I2(in[2]),.I3(in[3]),.I4(in[4]),.O(out[3]));
LUT5 #(.INIT(32'h59C69F21)) R2_B2 (.I0(in[0]),.I1(in[1]),.I2(in[2]),.I3(in[3]),.I4(in[4]),.O(out[2]));
LUT5 #(.INIT(32'hAE079C93)) R2_B1 (.I0(in[0]),.I1(in[1]),.I2(in[2]),.I3(in[3]),.I4(in[4]),.O(out[1]));
LUT5 #(.INIT(32'h987D8936)) R2_B0 (.I0(in[0]),.I1(in[1]),.I2(in[2]),.I3(in[3]),.I4(in[4]),.O(out[0]));

endmodule
 
module RotorR2inv(
   input [4:0] in,
   output [4:0] out);
      
//Rotor  GTZQ.FY >EWP@IA$LOXRJBN,UKCHVSMD
//Hex block B4 :  10B67E8E
//Hex block B3 :  E074959D
//Hex block B2 :  DD24332B
//Hex block B1 :  97C3B08D
//Hex block B0 :  940FC5BA
LUT5 #(.INIT(32'h10B67E8E)) R2inv_B4 (.I0(in[0]),.I1(in[1]),.I2(in[2]),.I3(in[3]),.I4(in[4]),.O(out[4]));
LUT5 #(.INIT(32'hE074959D)) R2inv_B3 (.I0(in[0]),.I1(in[1]),.I2(in[2]),.I3(in[3]),.I4(in[4]),.O(out[3]));
LUT5 #(.INIT(32'hDD24332B)) R2inv_B2 (.I0(in[0]),.I1(in[1]),.I2(in[2]),.I3(in[3]),.I4(in[4]),.O(out[2]));
LUT5 #(.INIT(32'h97C3B08D)) R2inv_B1 (.I0(in[0]),.I1(in[1]),.I2(in[2]),.I3(in[3]),.I4(in[4]),.O(out[1]));
LUT5 #(.INIT(32'h940FC5BA)) R2inv_B0 (.I0(in[0]),.I1(in[1]),.I2(in[2]),.I3(in[3]),.I4(in[4]),.O(out[0]));

endmodule
 
module RotorR3(
   input [4:0] in,
   output [4:0] out);
      
//Rotor  @WHLNDSUFK>$GBEP,ZTXJMI YVCARQ.O
//Hex block B4 :  738F0CC3
//Hex block B3 :  C1F38E19
//Hex block B2 :  8229DD97
//Hex block B1 :  C48C9A6F
//Hex block B0 :  521EAD3C
LUT5 #(.INIT(32'h738F0CC3)) R3_B4 (.I0(in[0]),.I1(in[1]),.I2(in[2]),.I3(in[3]),.I4(in[4]),.O(out[4]));
LUT5 #(.INIT(32'hC1F38E19)) R3_B3 (.I0(in[0]),.I1(in[1]),.I2(in[2]),.I3(in[3]),.I4(in[4]),.O(out[3]));
LUT5 #(.INIT(32'h8229DD97)) R3_B2 (.I0(in[0]),.I1(in[1]),.I2(in[2]),.I3(in[3]),.I4(in[4]),.O(out[2]));
LUT5 #(.INIT(32'hC48C9A6F)) R3_B1 (.I0(in[0]),.I1(in[1]),.I2(in[2]),.I3(in[3]),.I4(in[4]),.O(out[1]));
LUT5 #(.INIT(32'h521EAD3C)) R3_B0 (.I0(in[0]),.I1(in[1]),.I2(in[2]),.I3(in[3]),.I4(in[4]),.O(out[0]));

endmodule
 
module RotorR3inv(
   input [4:0] in,
   output [4:0] out);
//Rotor  @WHLNDSUFK>$GBEP,ZTXJMI YVCARQ.O
//Hex block B4 :  1FAB5305
//Hex block B3 :  A923C477
//Hex block B2 :  0C17F35A
//Hex block B1 :  AC9CC995
//Hex block B0 :  86F1DC0B
LUT5 #(.INIT(32'h1FAB5305)) R3inv_B4 (.I0(in[0]),.I1(in[1]),.I2(in[2]),.I3(in[3]),.I4(in[4]),.O(out[4]));
LUT5 #(.INIT(32'hA923C477)) R3inv_B3 (.I0(in[0]),.I1(in[1]),.I2(in[2]),.I3(in[3]),.I4(in[4]),.O(out[3]));
LUT5 #(.INIT(32'h0C17F35A)) R3inv_B2 (.I0(in[0]),.I1(in[1]),.I2(in[2]),.I3(in[3]),.I4(in[4]),.O(out[2]));
LUT5 #(.INIT(32'hAC9CC995)) R3inv_B1 (.I0(in[0]),.I1(in[1]),.I2(in[2]),.I3(in[3]),.I4(in[4]),.O(out[1]));
LUT5 #(.INIT(32'h86F1DC0B)) R3inv_B0 (.I0(in[0]),.I1(in[1]),.I2(in[2]),.I3(in[3]),.I4(in[4]),.O(out[0]));

endmodule
 
module RotorR4(
   input [4:0] in,
   output [4:0] out);
//Rotor  U.NG>ALXKZY,RDSOFTV@MBIHWJ$ CQEP
//Hex block B4 :  2D0E5E93
//Hex block B3 :  8E588F56
//Hex block B2 :  C59D889D
//Hex block B1 :  9D8AE1CA
//Hex block B0 :  86A732D6
LUT5 #(.INIT(32'h2D0E5E93)) R4_B4 (.I0(in[0]),.I1(in[1]),.I2(in[2]),.I3(in[3]),.I4(in[4]),.O(out[4]));
LUT5 #(.INIT(32'h8E588F56)) R4_B3 (.I0(in[0]),.I1(in[1]),.I2(in[2]),.I3(in[3]),.I4(in[4]),.O(out[3]));
LUT5 #(.INIT(32'hC59D889D)) R4_B2 (.I0(in[0]),.I1(in[1]),.I2(in[2]),.I3(in[3]),.I4(in[4]),.O(out[2]));
LUT5 #(.INIT(32'h9D8AE1CA)) R4_B1 (.I0(in[0]),.I1(in[1]),.I2(in[2]),.I3(in[3]),.I4(in[4]),.O(out[1]));
LUT5 #(.INIT(32'h86A732D6)) R4_B0 (.I0(in[0]),.I1(in[1]),.I2(in[2]),.I3(in[3]),.I4(in[4]),.O(out[0]));
endmodule
 
module RotorR4inv(
   input [4:0] in,
   output [4:0] out);

//Rotor  U.NG>ALXKZY,RDSOFTV@MBIHWJ$ CQEP
//Hex block B4 :  C46993B6
//Hex block B3 :  9747C61C
//Hex block B2 :  2087D99F
//Hex block B1 :  D5A4E9D0
//Hex block B0 :  5E89C2CB
LUT5 #(.INIT(32'hC46993B6)) R4inv_B4 (.I0(in[0]),.I1(in[1]),.I2(in[2]),.I3(in[3]),.I4(in[4]),.O(out[4]));
LUT5 #(.INIT(32'h9747C61C)) R4inv_B3 (.I0(in[0]),.I1(in[1]),.I2(in[2]),.I3(in[3]),.I4(in[4]),.O(out[3]));
LUT5 #(.INIT(32'h2087D99F)) R4inv_B2 (.I0(in[0]),.I1(in[1]),.I2(in[2]),.I3(in[3]),.I4(in[4]),.O(out[2]));
LUT5 #(.INIT(32'hD5A4E9D0)) R4inv_B1 (.I0(in[0]),.I1(in[1]),.I2(in[2]),.I3(in[3]),.I4(in[4]),.O(out[1]));
LUT5 #(.INIT(32'h5E89C2CB)) R4inv_B0 (.I0(in[0]),.I1(in[1]),.I2(in[2]),.I3(in[3]),.I4(in[4]),.O(out[0]));
endmodule
 
module RotorRF(
   input [4:0] in,
   output [4:0] out);
//Rotor  RDOBJNTKVEHMLFCWZAXGYIPSUQ@$>, .
//Hex block B4 :  FF958141
//Hex block B3 :  FC7118B4
//Hex block B2 :  3D4CAF24
//Hex block B1 :  CCCCD4C6
//Hex block B0 :  9845357B
LUT5 #(.INIT(32'hFF958141)) RF_B4 (.I0(in[0]),.I1(in[1]),.I2(in[2]),.I3(in[3]),.I4(in[4]),.O(out[4]));
LUT5 #(.INIT(32'hFC7118B4)) RF_B3 (.I0(in[0]),.I1(in[1]),.I2(in[2]),.I3(in[3]),.I4(in[4]),.O(out[3]));
LUT5 #(.INIT(32'h3D4CAF24)) RF_B2 (.I0(in[0]),.I1(in[1]),.I2(in[2]),.I3(in[3]),.I4(in[4]),.O(out[2]));
LUT5 #(.INIT(32'hCCCCD4C6)) RF_B1 (.I0(in[0]),.I1(in[1]),.I2(in[2]),.I3(in[3]),.I4(in[4]),.O(out[1]));
LUT5 #(.INIT(32'h9845357B)) RF_B0 (.I0(in[0]),.I1(in[1]),.I2(in[2]),.I3(in[3]),.I4(in[4]),.O(out[0]));

endmodule