module hazard(MemRead,ID_EX_Rt,rt,rs,PCSrc,IFflush,IDflush,EXflush,PCwrite,IFID);
     
//I/O ports
input		MemRead;
input		[4:0] ID_EX_Rt;
input		[4:0] rs,rt;
input		PCSrc;

output wire	IFflush,IDflush,EXflush;
output wire	PCwrite,IFID;
		//[25:21]Rs [20:16]Rt [15:11]Rd
		assign PCwrite=(MemRead&&((ID_EX_Rt==rs)||(ID_EX_Rt==rt)))?1:0;
		assign IFID=(MemRead&&((ID_EX_Rt==rs)||(ID_EX_Rt==rt)))?1:0;
		assign IDflush=(MemRead&&((ID_EX_Rt==rs)||(ID_EX_Rt==rt)))?1:0;

endmodule