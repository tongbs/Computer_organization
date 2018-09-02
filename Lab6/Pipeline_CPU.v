module Pipeline_CPU( clk_i, rst_n );

//I/O port
input         clk_i;
input         rst_n;

//======================================

//Internal Signles
wire [31:0]add_pc,pc_im,im_out;
wire [31:0]sign_out,zero_out;
wire [31:0]RF_out1,RF_out2;
wire [31:0]mux_alu,mux3_out;
wire [3:0]ALU_operation;
wire [1:0]FURslt;
wire [31:0]ALU_result,shifter_result;
wire RegDst,ALUSrc,RegWrite;
wire [2:0] ALUOP;
wire [4:0]mux2_rf;
wire zero,overflow;

//IF_ID
wire [31:0]IF_ID_add_pc,IF_ID_im_out;
//ID_EX
wire [31:0]ID_EX_RF_out1,ID_EX_RF_out2,ID_EX_sign_out,ID_EX_zero_out,ID_EX_add_pc;
wire [25:0]ID_EX_im_out;
wire [1:0]WB,ID_EX_WB;
wire [2:0]M,ID_EX_M;
wire [5:0]EX,ID_EX_EX;
//EX_MEM
wire [31:0]EX_MEM_add_sign,EX_MEM_RF_out2,EX_MEM_mux3_out;
wire EX_MEM_Branch_o;
wire [4:0]EX_MEM_mux2_rf;
wire [1:0]EX_MEM_WB;
wire [2:0]EX_MEM_M;

wire [31:0]Data_Memory_o;
wire [31:0]DMtoRF_o;
wire Branch_o,PCSrc;
wire [31:0]sign_shift;
wire [31:0]ins_shift;
wire [31:0]add_sign;
wire [31:0]add_mux_o;
wire Branch,BranchType,Jump,MemRead,MemWrite,MemtoReg;
wire [31:0]pc_i;
wire [31:0]jump_a;

//MEM_WB
wire [31:0]MEM_WB_Data_Memory_o,MEM_WB_mux3_out;
wire [1:0]MEM_WB_WB;
wire [4:0]MEM_WB_mux2_rf;


wire IFIDwrite,PCwrite;
wire IFflush,IDflush,EXflush;
wire [10:0] decoder_o,hdmux_o;
wire [1:0] Fa,Fb;
wire [31:0]FA_mux_o,FB_mux_o;


//IF stage
Mux2to1 #(.size(32)) add_mux(
        .data0_i(add_pc),
        .data1_i(EX_MEM_add_sign),
        .select_i(PCSrc),
        .data_o(add_mux_o)
        );
		  
Program_Counter PC(
        .clk_i(clk_i),      
	    .rst_n(rst_n),     
	    .pc_in_i(add_mux_o) ,   
	    .pc_out_o(pc_im),
		 .PCwrite(PCwrite)
	    );
	
Adder Adder1(
        .src1_i(pc_im),     
	    .src2_i(32'd4),
	    .sum_o(add_pc)    
	    );
	
Instr_Memory IM(
        .pc_addr_i(pc_im),  
	    .instr_o(im_out)    
	    );

pipeline_register #(.size(32)) IFIDadder(
			.clk(clk_i),
			.rst(rst_n),
			.data_i(add_pc),
			.data_o(IF_ID_add_pc),
			.pwrite(IFIDwrite)
			);

pipeline_register #(.size(32)) IF_ID_IM(
			.clk(clk_i),
			.rst(rst_n),
			.data_i(im_out),
			.data_o(IF_ID_im_out),
			.pwrite(IFIDwrite)
			);

//ID		
hazard hazrad(
			.MemRead(ID_EX_M[1]),
			.ID_EX_Rt(ID_EX_im_out[20:16]),
			.rt(IF_ID_im_out[20:16]),
			.rs(IF_ID_im_out[25:21]),
			.PCSrc(PCSrc),
			.IFflush(IFflush),
			.IDflush(IDflush),
			.EXflush(EXflush),
			.PCwrite(PCwrite),
			.IFID(IFIDwrite)
			);
			
Reg_File RF(
        .clk_i(clk_i),      
	    .rst_n(rst_n) ,     
        .RSaddr_i(IF_ID_im_out[25:21]) ,  
        .RTaddr_i(IF_ID_im_out[20:16]) ,  
        .Wrtaddr_i(MEM_WB_mux2_rf) ,  
        .Wrtdata_i(DMtoRF_o)  , 
        .RegWrite_i(MEM_WB_WB[1]),
        .RSdata_o(RF_out1) ,  
        .RTdata_o(RF_out2)   
        );

pipeline_register #(.size(32)) IDEXRF1(
			.clk(clk_i),
			.rst(rst_n),
			.data_i(RF_out1),
			.data_o(ID_EX_RF_out1),
			.pwrite(1'b0)
			);

pipeline_register #(.size(32)) IDEXRF2(
			.clk(clk_i),
			.rst(rst_n),
			.data_i(RF_out2),
			.data_o(ID_EX_RF_out2),
			.pwrite(1'b0)
			);			

Sign_Extend SE(
        .data_i(IF_ID_im_out[15:0]),
        .data_o(sign_out)
        );
		  
pipeline_register #(.size(32)) ID_EX_sign(
			.clk(clk_i),
			.rst(rst_n),
			.data_i(sign_out),
			.data_o(ID_EX_sign_out),
			.pwrite(1'b0)
			);			  

Zero_Filled ZF(
        .data_i(IF_ID_im_out[15:0]),
        .data_o(zero_out)
        );
		  
pipeline_register #(.size(32)) IDEXzero(
			.clk(clk_i),
			.rst(rst_n),
			.data_i(zero_out),
			.data_o(ID_EX_zero_out),
			.pwrite(1'b0)
			);

pipeline_register #(.size(26)) IDEXinstr(
			.clk(clk_i),
			.rst(rst_n),
			.data_i(IF_ID_im_out[25:0]),
			.data_o(ID_EX_im_out),
			.pwrite(1'b0)
			);
	
Decoder Decoder(
        .instr_op_i(IF_ID_im_out[31:26]), 
	    .RegWrite_o(RegWrite), 
	    .ALUOp_o(ALUOP),   
	    .ALUSrc_o(ALUSrc),  
	    .RegDst_o(RegDst),
		 .Branch_o(Branch),
		 .BranchType_o(BranchType),
		 .Jump_o(Jump),/***************************/
		 .MemRead_o(MemRead),
		 .MemWrite_o(MemWrite),
		 .MemtoReg_o(MemtoReg)
		);

assign decoder_o={RegWrite,MemtoReg,Branch,MemRead,MemWrite,RegDst,BranchType,ALUOP,ALUSrc};


Mux2to1 #(.size(11)) HD_mux(
        .data0_i(decoder_o),
        .data1_i(11'b0),
        .select_i(IDflush),
        .data_o(hdmux_o)
        );
		  
pipeline_register #(.size(2)) IDEXcontrol1(
			.clk(clk_i),
			.rst(rst_n),
			.data_i(hdmux_o[10:9]),//WB
			.data_o(ID_EX_WB),
			.pwrite(1'b0)
			);
			
pipeline_register #(.size(3)) IDEXcontrol2(
			.clk(clk_i),
			.rst(rst_n),
			.data_i(hdmux_o[8:6]),//M
			.data_o(ID_EX_M),
			.pwrite(1'b0)
			);
			
pipeline_register #(.size(6)) IDEXcontroller3(
			.clk(clk_i),
			.rst(rst_n),
			.data_i(hdmux_o[5:0]),//EX
			.data_o(ID_EX_EX),
			.pwrite(1'b0)
			);

pipeline_register #(.size(32)) IDEXadder(
			.clk(clk_i),
			.rst(rst_n),
			.data_i(IF_ID_add_pc),
			.data_o(ID_EX_add_pc),
			.pwrite(1'b0)
			);

//EX stage
forwarding forwarding(
			.Rs(ID_EX_im_out[25:21]),
			.Rt(ID_EX_im_out[20:16]),
			.EX_MEM_regwrite(EX_MEM_WB[1]),
			.MEM_WB_regwrite(MEM_WB_WB[1]),
			.EX_MEM_mux(EX_MEM_mux2_rf),
			.MEM_WB_mux(MEM_WB_mux2_rf),
			.FA(Fa),
			.FB(Fb)
			);

assign sign_shift=ID_EX_sign_out<<2;

Adder Adder2(
       .src1_i(ID_EX_add_pc),     
	    .src2_i(sign_shift),
	    .sum_o(add_sign)    
	    );

pipeline_register #(.size(32)) EXMEMadder(
			.clk(clk_i),
			.rst(rst_n),
			.data_i(add_sign),
			.data_o(EX_MEM_add_sign),
			.pwrite(1'b0)
			);

Mux3to1 #(.size(32)) FAmux(
        .data0_i(ID_EX_RF_out1),
        .data1_i(EX_MEM_mux3_out),
		  .data2_i(DMtoRF_o),
        .select_i(Fa),//RS
        .data_o(FA_mux_o)
        );
		  
Mux3to1 #(.size(32)) FBmux(
        .data0_i(ID_EX_RF_out2),
        .data1_i(EX_MEM_mux3_out),
		.data2_i(DMtoRF_o),
        .select_i(Fb),//RT
        .data_o(FB_mux_o)
        );
		  
Mux2to1 #(.size(32)) ALU_src2Src(
        .data0_i(FB_mux_o),
        .data1_i(ID_EX_sign_out),
        .select_i(ID_EX_EX[0]),
        .data_o(mux_alu)
        );	
		
ALU ALU(
		.aluSrc1(FA_mux_o),
	    .aluSrc2(mux_alu),
	    .ALU_operation_i(ALU_operation),
		.result(ALU_result),
		.zero(zero),
		.overflow(overflow)
	    );	

Mux2to1 #(.size(1)) BranchType_mux(
        .data0_i(zero),
        .data1_i(!zero),
        .select_i(ID_EX_EX[4]),
        .data_o(Branch_o)
        );

pipeline_register #(.size(1)) EX_MEM_Branch(
			.clk(clk_i),
			.rst(rst_n),
			.data_i(Branch_o),
			.data_o(EX_MEM_Branch_o),
			.pwrite(1'b0)
			);
		
Shifter shifter( 
		.result(shifter_result), 
		.leftRight(ALU_operation[3]),
		.shamt(ID_EX_im_out[10:6]),
		.sftSrc(mux_alu) 
		);
		
Mux3to1 #(.size(32)) RDdata_Source(
        .data0_i(ALU_result),
        .data1_i(shifter_result),
		.data2_i(ID_EX_zero_out),
        .select_i(FURslt),
        .data_o(mux3_out)
        );	
		  
pipeline_register #(.size(32)) EXMEMRF2(
			.clk(clk_i),
			.rst(rst_n),
			.data_i(ID_EX_RF_out2),
			.data_o(EX_MEM_RF_out2),
			.pwrite(1'b0)
			);

pipeline_register #(.size(32)) EXMEMmux3(
			.clk(clk_i),
			.rst(rst_n),
			.data_i(mux3_out),
			.data_o(EX_MEM_mux3_out),
			.pwrite(1'b0)
			);			
	
ALU_Ctrl AC(
        .funct_i(ID_EX_im_out[5:0]),   
        .ALUOp_i(ID_EX_EX[3:1]),   
        .ALU_operation_o(ALU_operation),
		  .FURslt_o(FURslt)
        );
	
Mux2to1 #(.size(5)) Mux_Write_Reg(
        .data0_i(ID_EX_im_out[20:16]),
        .data1_i(ID_EX_im_out[15:11]),
        .select_i(ID_EX_EX[5]),
        .data_o(mux2_rf)
        );
		  
pipeline_register #(.size(5)) EX_MEM_mux2(
			.clk(clk_i),
			.rst(rst_n),
			.data_i(mux2_rf),
			.data_o(EX_MEM_mux2_rf),
			.pwrite(1'b0)
			);
			
pipeline_register #(.size(2)) EX_MEM_control1(
			.clk(clk_i),
			.rst(rst_n),
			.data_i(ID_EX_WB),
			.data_o(EX_MEM_WB),
			.pwrite(1'b0)
			);
			
pipeline_register #(.size(3)) EX_MEM_control2(
			.clk(clk_i),
			.rst(rst_n),
			.data_i(ID_EX_M),
			.data_o(EX_MEM_M),
			.pwrite(1'b0)
			);
//MEM
and Branch_and(PCSrc,EX_MEM_M[2],EX_MEM_Branch_o);

Data_Memory DM(.clk_i(clk_i),
					.addr_i(EX_MEM_mux3_out),
					.data_i(EX_MEM_RF_out2),
					.MemRead_i(EX_MEM_M[1]),
					.MemWrite_i(EX_MEM_M[0]),
					.data_o(Data_Memory_o)
					);

pipeline_register #(.size(2)) MWcontrol(
			.clk(clk_i),
			.rst(rst_n),
			.data_i(EX_MEM_WB),
			.data_o(MEM_WB_WB),
			.pwrite(1'b0)
			);

pipeline_register #(.size(32)) MWDM(
			.clk(clk_i),
			.rst(rst_n),
			.data_i(Data_Memory_o),
			.data_o(MEM_WB_Data_Memory_o),
			.pwrite(1'b0)
			);

pipeline_register #(.size(32)) MWmux3(
			.clk(clk_i),
			.rst(rst_n),
			.data_i(EX_MEM_mux3_out),
			.data_o(MEM_WB_mux3_out),
			.pwrite(1'b0)
			);	

pipeline_register #(.size(5)) MWmux2(
			.clk(clk_i),
			.rst(rst_n),
			.data_i(EX_MEM_mux2_rf),
			.data_o(MEM_WB_mux2_rf),
			.pwrite(1'b0)
			);
//Write Back
Mux2to1 #(.size(32)) DMtoRF(
        .data0_i(MEM_WB_mux3_out),
        .data1_i(MEM_WB_Data_Memory_o),
        .select_i(MEM_WB_WB[0]),
        .data_o(DMtoRF_o)
        );
endmodule



