module Shifter( result, leftRight, shamt, sftSrc  );
    
  output wire[31:0] result;

  input wire leftRight;
  input wire[4:0] shamt;
  input wire[31:0] sftSrc ;
  
  /*your code here*/
  assign result = (shamt==0 && leftRight==1)?sftSrc<<0:
				  (shamt==1 && leftRight==1)?sftSrc<<1:
				  (shamt==2 && leftRight==1)?sftSrc<<2:
				  (shamt==3 && leftRight==1)?sftSrc<<3:
				  (shamt==4 && leftRight==1)?sftSrc<<4:
				  (shamt==5 && leftRight==1)?sftSrc<<5:
				  (shamt==6 && leftRight==1)?sftSrc<<6:
				  (shamt==7 && leftRight==1)?sftSrc<<7:
				  (shamt==8 && leftRight==1)?sftSrc<<8:
				  (shamt==9 && leftRight==1)?sftSrc<<9:
				  (shamt==10 && leftRight==1)?sftSrc<<10:
				  (shamt==11 && leftRight==1)?sftSrc<<11:
				  (shamt==12 && leftRight==1)?sftSrc<<12:
				  (shamt==13 && leftRight==1)?sftSrc<<13:
				  (shamt==14 && leftRight==1)?sftSrc<<14:
				  (shamt==15 && leftRight==1)?sftSrc<<15:
				  (shamt==16 && leftRight==1)?sftSrc<<16:
				  (shamt==17 && leftRight==1)?sftSrc<<17:
				  (shamt==18 && leftRight==1)?sftSrc<<18:
				  (shamt==19 && leftRight==1)?sftSrc<<19:
				  (shamt==20 && leftRight==1)?sftSrc<<20:
				  (shamt==21 && leftRight==1)?sftSrc<<21:
				  (shamt==22 && leftRight==1)?sftSrc<<22:
				  (shamt==23 && leftRight==1)?sftSrc<<23:
				  (shamt==24 && leftRight==1)?sftSrc<<24:
				  (shamt==25 && leftRight==1)?sftSrc<<25:
				  (shamt==26 && leftRight==1)?sftSrc<<26:
				  (shamt==27 && leftRight==1)?sftSrc<<27:
				  (shamt==28 && leftRight==1)?sftSrc<<28:
				  (shamt==29 && leftRight==1)?sftSrc<<29:
				  (shamt==30 && leftRight==1)?sftSrc<<30:
				  (shamt==31 && leftRight==1)?sftSrc<<31:
				  (shamt==0 && leftRight==0)?sftSrc>>0:
				  (shamt==1 && leftRight==0)?sftSrc>>1:
				  (shamt==2 && leftRight==0)?sftSrc>>2:
				  (shamt==3 && leftRight==0)?sftSrc>>3:
				  (shamt==4 && leftRight==0)?sftSrc>>4:
				  (shamt==5 && leftRight==0)?sftSrc>>5:
				  (shamt==6 && leftRight==0)?sftSrc>>6:
				  (shamt==7 && leftRight==0)?sftSrc>>7:
				  (shamt==8 && leftRight==0)?sftSrc>>8:
				  (shamt==9 && leftRight==0)?sftSrc>>9:
				  (shamt==10 && leftRight==0)?sftSrc>>10:
				  (shamt==11 && leftRight==0)?sftSrc>>11:
				  (shamt==12 && leftRight==0)?sftSrc>>12:
				  (shamt==13 && leftRight==0)?sftSrc>>13:
				  (shamt==14 && leftRight==0)?sftSrc>>14:
				  (shamt==15 && leftRight==0)?sftSrc>>15:
				  (shamt==16 && leftRight==0)?sftSrc>>16:
				  (shamt==17 && leftRight==0)?sftSrc>>17:
				  (shamt==18 && leftRight==0)?sftSrc>>18:
				  (shamt==19 && leftRight==0)?sftSrc>>19:
				  (shamt==20 && leftRight==0)?sftSrc>>20:
				  (shamt==21 && leftRight==0)?sftSrc>>21:
				  (shamt==22 && leftRight==0)?sftSrc>>22:
				  (shamt==23 && leftRight==0)?sftSrc>>23:
				  (shamt==24 && leftRight==0)?sftSrc>>24:
				  (shamt==25 && leftRight==0)?sftSrc>>25:
				  (shamt==26 && leftRight==0)?sftSrc>>26:
				  (shamt==27 && leftRight==0)?sftSrc>>27:
				  (shamt==28 && leftRight==0)?sftSrc>>28:
				  (shamt==29 && leftRight==0)?sftSrc>>29:
				  (shamt==30 && leftRight==0)?sftSrc>>30:
				   sftSrc>>31;
				  
	
endmodule