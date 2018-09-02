module forwarding(Rs,Rt,EX_MEM_regwrite,MEM_WB_regwrite,EX_MEM_mux,MEM_WB_mux,FA,FB);
     
//I/O ports
input	[4:0] Rs,Rt;
input EX_MEM_regwrite,MEM_WB_regwrite;
input [4:0] EX_MEM_mux,MEM_WB_mux;
output wire [1:0] FA,FB;
 
//Internal Signals
	
	assign FA=(EX_MEM_regwrite&&(EX_MEM_mux!=0)&&(EX_MEM_mux==Rs))?2'b01:
					(MEM_WB_regwrite&&(MEM_WB_mux!=0)&&(MEM_WB_mux==Rs))?2'b10:2'b00;
	
	
	assign FB=(EX_MEM_regwrite&&(EX_MEM_mux!=0)&&(EX_MEM_mux==Rt))?2'b01:
					(MEM_WB_regwrite&&(MEM_WB_mux!=0)&&(MEM_WB_mux==Rt))?2'b10:2'b00;


endmodule