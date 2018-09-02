//0413359
module Pipeline_CPU( clk_i, rst_n );

//I/O port
input         clk_i;
input         rst_n;

//IF stage
wire [32-1:0] pc_in;
wire [32-1:0] pcF;
wire [32-1:0] pcS;
wire [32-1:0] pc_out;
wire [32-1:0] instrF;
wire [32-1:0] instrS;
wire PCSrc;
//ID stage
wire [32-1:0] ZF_data;
wire [32-1:0] ZF_dataS;
wire [32-1:0] SE_dataS;
wire [32-1:0] RS_dataS;
wire [32-1:0] RT_dataS;
wire [32-1:0] pc_three;
wire 	ALUSrc;
wire 	RegDst;
wire 	Branch;
wire 	BranchType;
wire  	MemWrite;
wire 	MemRead;
wire [32-1:0] SE_data;
wire [32-1:0] RSdata;
wire [32-1:0] RTdata;
wire 	RegWrite;
wire [3-1:0] ALUOp;
wire 	MemtoReg;
wire 	RegWriteS;
wire [3-1:0] ALUOpS;
wire 	ALUSrcS;
wire 	RegDstS;
wire 	BranchS;
wire 	BranchTypeS;
wire  	MemWriteS;
wire 	MemReadS;
wire 	MemtoRegS;
wire [6-1:0] ALU_c;
wire [5-1:0] shamt;
wire [32-1:0] RS;
wire [32-1:0] RT;
//EX stage
wire not_zero;
wire zero;	
wire overflow;
wire [32-1:0] MemDataS;
wire	branch_result_T;
wire [5-1:0] target_dataS;
wire	branch_out;
wire [32-1:0] pc_fo;
wire [32-1:0] thing;
wire [5-1:0] target_data;
wire [4-1:0] ALU_operation;
wire [2-1:0] FURslt;
wire [32-1:0] pc_ex;
wire [32-1:0] RTdataT;
wire 	RegWriteT;
wire 	BranchT;
wire  	MemWriteT;
wire 	MemReadT;
wire 	MemtoRegT;
wire [32-1:0] ALUSrc2;
wire [32-1:0] result;
wire [32-1:0] SftRslt;
wire [32-1:0] MemData;
//MEM stage
wire [32-1:0] MemDataT;
wire [5-1:0] target_dataT;
wire [32-1:0] MemOutS;
wire [32-1:0] MemOut;
wire 	RegWriteFo;
wire 	MemtoRegFo;
//final output part
wire [32-1:0] address;

assign thing[31:2] = SE_dataS[29:0];
assign thing[1:0] = 0;
assign not_zero = ~zero;


Program_Counter PC(
        .clk_i(clk_i),      
	    .rst_n(rst_n),     
	    .pc_in_i(pc_in) ,   
	    .pc_out_o(pc_out) 
	    );
	
Adder AdderF(
        .src1_i(pc_out),     
	    .src2_i(32'd4),
	    .sum_o(pcF)    
	    );
//+++++++++++++++++++++++++++


Mux2to1 #(.size(32)) PCBranch(
        .data0_i(pcF),
        .data1_i(pc_ex),
        .select_i(PCSrc),
        .data_o(pc_in)
        );
		
Instr_Memory IM(
        .pc_addr_i(pc_out),  
	    .instr_o(instrF)    
	    );
		
IFtoID FD_reg(
		.clk(clk_i),
		.rst(rst_n),
		.PC(pcF),
		.instruction(instrF),
		.PC_o(pcS),
		.instr_o(instrS)
);
//+++++++++++++++++++++++++++	
		
		
/*Instr_Memory IM(
        .pc_addr_i(pc_out),  
	    .instr_o(instrF)    
	    );

Mux2to1 #(.size(5)) Mux_Write_Reg(
        .data0_i(instr[20:16]),
        .data1_i(instr[15:11]),
        .select_i(reg_dst),
        .data_o(Mux1_o)
        );

assign 	ra = 5'b11111;	
Mux2to1 #(.size(5)) Mux_jal1(
        .data0_i(Mux1_o),
        .data1_i(ra),
        .select_i(jal),
        .data_o(rd_addr)
        );
		
Mux2to1 #(.size(32)) Mux_jal2(
        .data0_i(Mux2_o),
        .data1_i(Adder1_o),
        .select_i(jal),
        .data_o(rd_data)
        );
		
Mux2to1 #(.size(32)) MemtoReg(
        .data0_i(result_alu),
        .data1_i(Mem_o),
        .select_i(Memtoreg),
        .data_o(Mux2_o)
        );

assign not_zero = (zero == 1) ? 0 : 1;		
Mux2to1 #(.size(1)) Choose_branch(
        .data0_i(zero),
        .data1_i(not_zero),
        .select_i(Branchtype),
        .data_o(mux_branch_result)
        );		
		
Mux2to1 #(.size(32)) Mux_pc_src(
        .data0_i(Adder1_o),
        .data1_i(Adder2_o),
        .select_i(pc_src),
        .data_o(branch_mux_o)
        );		
		
Mux2to1 #(.size(32)) Mux_Jump(
        .data0_i(branch_mux_o),
        .data1_i(jump_address),
        .select_i(Jump),
        .data_o(jump_mux_o)
        );
		
Mux2to1 #(.size(32)) Mux_Jr(
        .data0_i(jump_mux_o),
        .data1_i(rs_data),
        .select_i(Jr),
        .data_o(pc_in)
        );
		
check_branch CB(
        .branch(Branch),
        .zero(mux_branch_result),
        .pc_src(pc_src)
        );
		
CalculateJump CJ(
        .pc_bits(Adder1_o[31:28]),
        .instr_bits(instr[25:0]),
        .jump_address(jump_address)
        );

ShiftLeft SL(
        .Bshifted(SE_out),
        .Ashifted(Ashifted)
        );	
*/	
//+++++++++++++++++++++++++++++++++++++++	
//ID		
Reg_File RF(
        .clk_i(clk_i),      
	    .rst_n(rst_n) ,     
        .RSaddr_i(instrS[25:21]) ,  
        .RTaddr_i(instrS[20:16]) ,  
		.Wrtaddr_i(target_dataT) ,
		.Wrtdata_i(address) , 
        .RegWrite_i(RegWriteFo),
        .RSdata_o(RSdata) ,  
        .RTdata_o(RTdata)   
        );

Decoder Decoder(
        .instr_op_i(instrS[31:26]), 
	    .RegWrite_o(RegWrite), 
	    .ALUOp_o(ALUOp),   
	    .ALUSrc_o(ALUSrc),   
	    .RegDst_o(RegDst),
        .Branch_o(Branch),
        .Branch_type(BranchType),
        .MemRead_o(MemRead),
		.MemWrite_o(MemWrite),
        .MemtoReg_o(MemtoReg)  
		);

/*ALU_Ctrl AC(
        .funct_i(instr[5:0]),   
        .ALUOp_i(alu_op),   
        .ALU_operation_o(alu_operation),
		.FURslt_o(FURslt),
		.Jr(Jr)
        );
*/	
Sign_Extend SE(
        .data_i(instrS[15:0]),
        .data_o(SE_data)
        );

Zero_Filled ZF(
        .data_i(instrS[15:0]),
        .data_o(ZF_data)
        );
		
IDtoEX DE_reg(
	.clk(clk_i), 
	.rst(rst_n), 
	.ALU_i(instrS[5:0]),
	.shamt(instrS[10:6]),
	.ZF_data(ZF_data),
	.RegWrite(RegWrite), 
	.MemtoReg(MemtoReg), 
	.Branch(Branch), 
	.BranchType(BranchType), 
	.MemRead(MemRead), 
	.MemWrte(MemWrite), 
	.ALUSrc(ALUSrc), 
	.ALUOp(ALUOp), 
	.RegDst(RegDst), 
	.PC_i(pcS), 
	.RSdata(RSdata), 	
	.RTdata(RTdata), 	
	.SE_data(SE_data), 
	.RS(instrS[20:16]), 
	.RT(instrS[15:11]),
	.ALU_o(ALU_c),
	.shamt_o(shamt),
	.ZF_data_o(ZF_dataS), 
	.RegWrite_o(RegWriteS), 
	.MemtoReg_o(MemtoRegS), 
	.Branch_o(BranchS), 
	.BranchType_o(BranchTypeS), 
	.MemRead_o(MemReadS), 
	.MemWrte_o(MemWriteS), 
	.ALUSrc_o(ALUSrcS), 
	.ALUOp_o(ALUOpS), 
	.RegDst_o(RegDstS), 
	.PC_o(pc_three), 
	.RSdata_o(RS_dataS), 
	.RTdata_o(RT_dataS), 
	.SE_data_o(SE_dataS), 
	.RS_o(RS), 
	.RT_o(RT)
);
//++++++++++++++++++++++++++++++++++++++++
Adder AdderS(
        .src1_i(pc_three),     
	    .src2_i(thing),
	    .sum_o(pc_fo)
	    );

Mux2to1 #(.size(5)) MuxWReg(
        .data0_i(RS),
        .data1_i(RT),
        .select_i(RegDstS),
        .data_o(target_data)
        );	

ALU_Ctrl AC(
        .funct_i(ALU_c),   
        .ALUOp_i(ALUOpS),   
        .ALU_operation_o(ALU_operation),
		.FURslt_o(FURslt)
        );		
		
Mux2to1 #(.size(32)) ALU_src2Src(
        .data0_i(RT_dataS),
        .data1_i(SE_dataS),
        .select_i(ALUSrcS),
        .data_o(ALUSrc2)
        );	
		
ALU ALU(
		.aluSrc1(RS_dataS),
	    .aluSrc2(ALUSrc2),
	    .ALU_operation_i(ALU_operation),
		.result(result),
		.zero(zero),
		.overflow(overflow)
	    );
		
/*Data_Memory DM(
        .clk_i(clk_i),
        .addr_i(address),
        .data_i(rt_data),
        .MemRead_i(Memread),
        .MemWrite_i(Memwrite),
        .data_o(Mem_o)
        );
*/


Mux2to1 #(.size(1)) choose_branch(
        .data0_i(zero),
        .data1_i(not_zero),
        .select_i(BranchTypeS),
        .data_o(branch_out)
        );			
		
Shifter shifter( 
		.result(SftRslt), 
		.leftRight(ALU_operation[3]), 
		.shamt(shamt),
		.sftSrc(ALUSrc2) 
		);
//see ALU_Ctrl.v , 
//(funct_i == 0 || funct_i == 6)? 4'b0100: 4'b0000 //According to SPEC, alu_operation[2]=1 when shift left(funct = 0 | 6);		
		
Mux3to1 #(.size(32)) RDdata_Src(
        .data0_i(result),
        .data1_i(SftRslt),
		.data2_i(ZF_dataS),
        .select_i(FURslt),
        .data_o(MemData)
        );

EXtoMEM EM_reg(
	.clk(clk_i), 
	.rst(rst_n), 
	.RegWrite(RegWriteS), 
	.MemtoReg(MemtoRegS), 
	.Branch(BranchS), 
	.MemRead(MemReadS), 
	.MemWrte(MemWriteS), 
	.Zero(branch_out), 
	.PC_i(pc_fo), 
	.Result(MemData), 
	.RT_data(RT_dataS), 
	.target_data(target_data), 
	.RegWrite_o(RegWriteT), 
	.MemtoReg_o(MemtoRegT), 
	.Branch_o(BranchT), 
	.MemRead_o(MemReadT), 
	.MemWrte_o(MemWriteT), 
	.Zero_o(branch_result_T), 
	.PC_o(pc_ex), 
	.Result_o(MemDataS), 
	.RT_data_o(RTdataT), 
	.target_data_o(target_dataS)
);
//++++++++++++++++++++++++++++++++++++++++++++++
//MEM
and(PCSrc , branch_result_T , BranchT);

Data_Memory DM(	
	.clk_i(clk_i), 
	.addr_i(MemDataS), 
	.data_i(RTdataT), 
	.MemRead_i(MemReadT), 
	.MemWrite_i(MemWriteT), 
	.data_o(MemOut)
);

MEMtoWB MW_reg(
	.clk(clk_i), 
	.rst(rst_n), 
	.RegWrite(RegWriteT), 
	.MemtoReg(MemtoRegT), 
	.Result(MemDataS), 
	.MemData(MemOut), 
	.target_data(target_dataS), 
	.RegWrite_o(RegWriteFo), 
	.MemtoReg_o(MemtoRegFo), 
	.Result_o(MemDataT), 
	.MemData_o(MemOutS), 
	.target_data_o(target_dataT)
);

Mux2to1 #(.size(32)) last_dst(
        .data0_i(MemDataT),
        .data1_i(MemOutS),
        .select_i(MemtoRegFo),
        .data_o(address)
        );

endmodule



