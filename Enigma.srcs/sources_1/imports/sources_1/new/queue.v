`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Updated Date: 02/19/2021 06:51:10 PM
// Design Name: 
// Module Name: ring_counter
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



module queue(
    input clk,
    input advance, restart,
    output [4:0] Q
    );
    
    parameter WD = 8'd128;  // lenght of messages in chracters

    wire [127:0] msg4;
    wire [127:0] msg3;
    wire [127:0] msg2;
    wire [127:0] msg1;
    wire [127:0] msg0;

    wire ld;
    wire [(WD-1):0] Din4, Din3, Din2, Din1, Din0, Q4, Q3, Q2, Q1, Q0;
    
    assign ld=advance | restart;
    assign Din4 = {(WD){restart}}&msg4 | {(WD){~restart&advance}}&{1'b0,Q4[(WD-1):1]};
    assign Din3 = {(WD){restart}}&msg3 | {(WD){~restart&advance}}&{1'b0,Q3[(WD-1):1]};
    assign Din2 = {(WD){restart}}&msg2 | {(WD){~restart&advance}}&{1'b0,Q2[(WD-1):1]};
    assign Din1 = {(WD){restart}}&msg1 | {(WD){~restart&advance}}&{1'b0,Q1[(WD-1):1]};
    assign Din0 = {(WD){restart}}&msg0 | {(WD){~restart&advance}}&{1'b0,Q0[(WD-1):1]};
    
    FDRE #( .INIT(1'b0) ) B4ff[(WD-1):0] (.C({(WD){clk}}), .CE({(WD){ld}}), .D(Din4), .Q(Q4));
    FDRE #( .INIT(1'b0) ) B3ff[(WD-1):0] (.C({(WD){clk}}), .CE({(WD){ld}}), .D(Din3), .Q(Q3));
    FDRE #( .INIT(1'b0) ) B2ff[(WD-1):0] (.C({(WD){clk}}), .CE({(WD){ld}}), .D(Din2), .Q(Q2));
    FDRE #( .INIT(1'b0) ) B1ff[(WD-1):0] (.C({(WD){clk}}), .CE({(WD){ld}}), .D(Din1), .Q(Q1));
    FDRE #( .INIT(1'b0) ) B0ff[(WD-1):0] (.C({(WD){clk}}), .CE({(WD){ld}}), .D(Din0), .Q(Q0));
    
    assign Q = {Q4[0], Q3[0], Q2[0], Q1[0], Q0[0]};
    
    // possible encoded messages
    
    //Seeds are S1:  0    S2:  0   S3:  0   S4:  0
//Original message:
//"HELLO WORLD                                                                                                          GO SLUGS   "
//Encoded message:
//"YSTA,VJGMQLI$L,>YVXCPHAAIM$SUUJVLVMN.ZE.ZIDJ>$LXQJVRI>HMX,LY$.ZJPYDVP$RLBCVR@EGTWS,DYF$QJFOVRD$,YOJFFAPNIDMUFMPPDLRE@ AP.>YZWQ,I"
assign msg4 = 128'h7F340801D8D79C6A7B2DB1B2BC07D237;
assign msg3 = 128'hCFB2E5C7C55410B3FEB27BBD4711FD51;
assign msg2 = 128'h5298FCDACE65743913E4B04EB636D1B0;
assign msg1 = 128'h11B3C242644BD2B53540E4910C3C3486;
assign msg0 = 128'h0B87D2DC7B688DFDF56EFDBBC436B464;

//Seeds are S1:  0    S2:  0   S3:  0   S4:  0
//Original message:
//"HELP ME HELP ME HELP ME HELP ME HELP ME HELP ME HELP ME HELP ME HELP ME HELP ME HELP ME HELP GO SLUGS ME HELP ME HELP ME HELP ME"
//Encoded message:
//"YST>ZSC>UMDU$HS>B,MIPPJACFZNUP>VMTCM.@ .K.JA>.BXIC@OINVMGX F$JDJR.U@PCALSNGE@OTTQ$GWY>ZQM$CLROQ,OCC.AAIVIZIZDMK.DJSWYG YW,PWAQVN"
//assign msg4 = 128'h6BDC8A88D2FBD10F1644B2F2D402D9BF;
//assign msg3 = 128'h86D2EF49AB72329AB4BD37F96C7E9299;
//assign msg2 = 128'hCF282081A32E3E1C1BEC9029FA36BB88;
//assign msg1 = 128'h0D6DD00F2E0EF5BA570EA3F621307466;
//assign msg0 = 128'hC4039A881A62C293FA60F692EE71B49C;

//Seeds are S1:  0    S2:  0   S3:  0   S4:  0
//Original message:
//"HELLO WORLD                                                                                                             GO SLUGS"
//Encoded message:
//"YSTA,VJGMQLI$L,>YVXCPHAAIM$SUUJVLVMN.ZE.ZIDJ>$LXQJVRI>HMX,LY$.ZJPYDVP$RLBCVR@EGTWS,DYF$QJFOVRD$,YOJFFAPNIDMUFMPPDLRE@GMPRAH,>JYH"
//assign msg4 = 128'h59140801D8D79C6A7B2DB1B2BC07D237;
//assign msg3 = 128'h78D2E5C7C55410B3FEB27BBD4711FD51;
//assign msg2 = 128'h9CF8FCDACE65743913E4B04EB636D1B0;
//assign msg1 = 128'h84B3C242644BD2B53540E4910C3C3486;
//assign msg0 = 128'hB587D2DC7B688DFDF56EFDBBC436B464;

//Seeds are S1:  15    S2:  2   S3:  9   S4:  10
//Original message:
//"HELP ME HELP ME HELP ME HELP ME HELP ME HELP ME HELP ME HELP ME HELP ME HELP ME HELP ME HELP GO SLUGS ME HELP ME HELP ME HELP ME"
//Encoded message:
//"L@$QXLRG,YSLCLFR ,NSVOZ.FGIY$RHZUBTO,NN,SMDEALD$UMDEWBVIZ,MTFBZ,UF QF IPYTTAZOFPSTOTVHPIZHASHZJVLGBL$MFL@S$YE$XZ>YMDHMBMWN,FZFP,"
 //assign msg4 = 128'h9503EF10A91B172DCB518195B8DB875E;
 //assign msg3 = 128'hD6A7ADB961C4B1E4C782A2F89CE72B27;
 //assign msg2 = 128'hEFB575729274E093965B8AF953364196;
 //assign msg1 = 128'h4118679B1A6FA6A40814E50C52A93CB7;
 //assign msg0 = 128'h7A59E4DDF37AD6927964E466F1D4E875;

//Seeds are S1:  31    S2:  31   S3:  31   S4:  31
//Original message:
//"HELLO WORLD                                                                                                             GO SLUGS"
//Encoded message:
//"RBITUZ>TA>AXI$L,>YVXCPHAAIM$SUUJVLVMN.ZE.ZIDJ>$LXQJVRI>HMX,LY$.ZJPYDVP$RLBCVR@EGTWS,DYF$QJFOVRD$,YOJFFAPNIDMUFMPPDLRE@GMRZRJWGPE"
//assign msg4 = 128'h17281003B1AF38D4F65B6365780FAAF9;
//assign msg3 = 128'h4AA5CB8F8AA82167FD64F77A8E23F264;
//assign msg2 = 128'hF0F1F9B59CCAE87227C9609D6C6DAA50;
//assign msg1 = 128'h70678484C897A56A6A81C92218786888;
//assign msg0 = 128'h4F0FA5B8F6D11BFBEADDFB77886D6AEB;

//Seeds are S1:  7    S2:  12   S3:  18   S4:  29
//Original message:
//"GO SLUGS GO SLUGS GO SLUGS GO SLUGS GO SLUGS GO SLUGS GO SLUGS GO SLUGS GO SLUGS GO SLUGS GO SLUGS GO SLUGS GO SLUGS GO SLUGS GO "
//Encoded message:
//"HAYG>DKBXYJDYGR PAB,RRZ M$IPFDICCVAO>DRIAI,GE..NEY@,,ETIV@VKAIWQAAW>QSOUYC@.$OKMZ ,HJZTPROATBUQISGKLCFR$EICY DQTASFQV.DYH.MCKKWZV"
//assign msg4 = 128'hC2BAD8C169671DBCC75E645202F8D314;
//assign msg3 = 128'hB6A01A8C82B7FD482A9EE6984FC99654;
//assign msg2 = 128'h451401A2228CB4CC473D9C1A1B092119;
//assign msg1 = 128'h7B62B49F0ACA7E644A446829AA81A969;
//assign msg0 = 128'h8374A0E819F918080540E0723A754DB1;

//Seeds are S1:  11    S2:  2   S3:  9   S4:  10
//Original message:
//"HELP ME PLEASE HELP HELP ME PLEASE HELP ME PLEASE HELP HELP ME PLEASE HELP ME PLEASE HELP HELP ME PLEASE HELP ME PLEASE HELP HEL"
//Encoded message:
//"MQCHWAMJOMREOYFIFM@R ,NSVOZ.,@G.NG.NXFQ,HJYUCMJU$H$.G@@YP QIQ,NTYZLAIY,R,CJLIPRWAPBD@@RECDKZ@ $RBBMOV.XJTCHEWNZNWUGZLKMXP.ZJWN,F"
//assign msg4 = 128'h568B5170F870C1E3B6ED8CD4BDBC2412;
//assign msg3 = 128'h6F78E0AC7C323D776BED668DBE76B3C1;
//assign msg2 = 128'hF1C7BC5C50B2A1406177A9BB73675B59;
//assign msg1 = 128'h13B51768773AAA04837F1116EA94111C;
//assign msg0 = 128'hAF98E5F3CA4E6C86C10F433D8D494488;

//Seeds are S1:  11    S2:  2   S3:  9   S4:  10
//Original message:
//"HELP ME PLEASE HELP HELP ME PLEASE HELP GO SLUGS PLEASE HELP HELP ME PLEASE HELP ME PLEASE HELP HELP ME PLEASE HELP ME PLEASE HE"
//Encoded message:
//"MQCHWAMJOMREOYFIFM@R ,NSVOZ.,@G.NG.NXFQ,PFYRCWBUA.K..HPJFGAO.WPK@FQZLL RE>IPYTTAZOFPBQRVO$FAJ,UJ $QKFJA>EWHF>BLAPCS$R BET.IBNTVM"
//assign msg4 = 128'h633C128762E172CD301AACD4BDBC2412;
//assign msg3 = 128'h962950ABB30B1E79D8DE058DBE76B3C1;
//assign msg2 = 128'hD0891F92678E0B036B60A3BB73675B59;
//assign msg1 = 128'h232F460B030A6871FA7E3116EA94111C;
//assign msg0 = 128'h7B597CB296DD6ABA51FA4B3D8D494488;
    
//Seeds are S1:  31    S2:  31   S3:  31   S4:  31
//Original message:
//"HELP ME HELP ME HELP ME HELP ME HELP ME HELP ME HELP ME HELP ME HELP ME HELP ME HELP ME HELP GO SLUGS ME HELP ME HELP ME HELP ME"
//Encoded message:
//"RBIV.SHM,BQKI.K,BJ@SC@$AGXISSOHJMNGBNZBEV$,@JLWLMV>QRWTHIWUMY>FZK$NFVR>RFG$RRR G@YUADDG$,NGIVNG$I,$.>FBNNTOWNF AP>PW>@$CPNPFYIBS"
//assign msg4 = 128'h907A4A1E91877CF2B67E4F201A6CA539;
//assign msg3 = 128'h3777559FAB834447B905BE33A466F994;
//assign msg2 = 128'h0F7F3DB6F7C5875E6EA74F97636481C8;
//assign msg1 = 128'h85ED4E0CC4F1C60302E0EA047B7C6870;
//assign msg0 = 128'h4F5733FCB2B03DFEE0D6B37AC243225B;    
  
//Seeds are S1:  31    S2:  31   S3:  31   S4:  30
//Original message:
//"HELLO WORLD                                                                                                             GO SLUGS"
//Encoded message:
//"E FBFHSDS>>QIAFDF@NUQWIARPMPBU@.ZE.Z$.ZEJV$QIIKVDQ@E@BWLWRMMTQK.ZIYRH.ZFJB@FMMWMTNPD@CPLW,DYRSII,YF@HBCWPBF@TPSWTNCDEP,@TDS.AYRW"
//assign msg4 = 128'hEDC1D88B3B11446DB3568E7DE13A0F42;
//assign msg3 = 128'h28E2290BCAD6B567CC94757DCE461602;
//assign msg2 = 128'h80F2AD9D0356FC900D5C86926E2F4635;
//assign msg1 = 128'h8FADF9D825FD4430D1D54434CA2281E2;
//assign msg0 = 128'h4B2B373414CF0BF992A1877D9B05C6BC;    


// I ADDED THIS
//Seeds are S1:  31    S2:  31   S3:  31   S4:  31
//Original message:
//"HELP ME HELP ME HELP ME HELP ME HELP ME HELP ME HELP ME HELP ME HELP ME HELP ME HELP ME HELP GO SLUGS ME HELP ME HELP ME HELP ME"
//Encoded message:
//"E FBFHSDS>>QIAFDF@NUQWIARPMPBU@.ZE.Z$.ZEJV$QIIKVDQ@E@BWLWRMMTQK.ZIYRH.ZFJB@FMMWMTNPD@CPLW,DYRSII,YF@HBCWPBF@TPSWTNCDEP,@TDS.AYRW"
//assign msg4 = 128'hC31BB162E8BF58753665B305A8EB9A39;
//assign msg3 = 128'h7D835DE19B0CA52B990EE533BAD0EF94;
//assign msg2 = 128'h046675BAA6DE1E176EA7A9AEFCD98EC8;
//assign msg1 = 128'h9673A6A781D5932202D32220C82BF870;
//assign msg0 = 128'h4B8B19D1F7872E1760ED0316DEECD35B;
 
//Seeds are S1:  30    S2:  31   S3:  31   S4:  31
//Original message:
//"HELLO WORLD                                                                                                             GO SLUGS"
//Encoded message:
//"RNGIU..ALZ@FXI$L,>YVXCPHAAIM$SUUJVLVMN.ZE.ZIDJ>$LXQJVRI>HMX,LY$.ZJPYDVP$RLBCVR@EGTWS,DYF$QJFOVRD$,YOJFFAPNIDMUFMPPDLRE@GVIWDFAU@"
//assign msg4 = 128'hC5502007635E71A9ECB6C6CAF01F5671;
//assign msg3 = 128'h824B971F155042CFFAC9EEF51C47E76A;
//assign msg2 = 128'hD5E3F36B3995D0E44F92C13AD8DB5C16;
//assign msg1 = 128'h8CCF0909912F4AD4D503924430F0D564;
//assign msg0 = 128'h191F4B71EDA237F7D5BBF6EF10DADB63;
 
 //Mystery Encoded message:
//"LBSD@SXTD>UD>WOKUAKMFOTKJSQN>HHTTPRWXKIG>,XSCJPWPUGKXMLNLWQLJL MOXKR.TPFGCPZC.OVFPM,GNY>NDJFGC.BLURCC@PEDAGD$ZS@BJBR@J.LE,>ZV ZE"
//assign msg4 = 128'h7E58F02640C8A83A46128F1D964136F4;
//assign msg3 = 128'h6EF2B06145EE6C55F9E9636219ACD211;
//assign msg2 = 128'h971094E219BFC5C382B7C79A78397650;
//assign msg1 = 128'h20D0DD79721277776B5DDCBBE2E4E9FD;
//assign msg0 = 128'h5CEF3945CFA3ACFA39D16517F9501BCB;   



//Mystery 2
//"DPZ>IG,MSSKE>LSXNDFXQ@ZUE@WHMDWCXSSHSCJDXBEU$FLRFD$QA$.AEAMEO$$VK,S>YED.$Y ,>$.RX$B ,GRJMTJV QMJBUMZVZZJFJTOK >GOX>DMM>.PXUHD@OU"
//assign msg4 = 128'hA6C6647A3A5BFF9EE06C991746F8D34C;
//assign msg3 = 128'h61F57AECD59A7F9B74645040126134DE;
//assign msg2 = 128'hEF77C9164933392AFD253D095FAD98EA;
//assign msg1 = 128'h7B8BBC00122B65C5706651BFEE2AE723;
//assign msg0 = 128'h1BCE47F98EC7F1C8E067F3C9284FB00F;

// Mystery 3
//Encoded message:
//"YST>ZSC>UMDU$HS>B,MIPPJACFZNUP>VZV$P.E LLJDIRBUXOQZBNMVCXJSYWQLEPJF$.SRPFC.CLRJT>T,WQGXLNFYJVR$EWO,WX,PD.D,QB@PARLV RBMVTREWZLEN"
//                                                                                            GO SLUGS"
//assign msg4 = 128'h1B9D2D3D745FA4783D46D057D402D9BF;
//assign msg3 = 128'hB04A65664D85549B4A350BDD6C7E9299;
//assign msg2 = 128'hCCC4647FD36D018D9171C02EFA36BB88;
//assign msg1 = 128'h290A63DB40EA9EB9558185DC21307466;
//assign msg0 = 128'hB3B753D07BC3F5DF435CB79FEE71B49C;

endmodule




