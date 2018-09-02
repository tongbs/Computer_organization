module Simple_Single_CPU( clk_i, rst_n );

//I/O port
input         clk_i;
input         rst_n;

//Internal Signles

//Program_Counter
wire [32-1:0] pc_in;
wire [32-1:0] pc_out;
//Instr_Memory
wire [32-1:0] instr;
//Decoder
wire reg_dst;
wire reg_write;
wire [3-1:0] alu_op;
wire alu_src;
//Reg_File
/*rs_addr,rt_addr is instr[25-21], instr[20-16] respectively*/
wire [5-1:0] rd_addr;
wire [32-1:0] rd_data;
wire [32-1:0] rs_data;
wire [32-1:0] rt_data;
//ALU_Ctrl
wire [4-1:0] alu_operation;
wire [2-1:0] FURslt;
//Sign_Extend
wire [32-1:0] SE_out;
//Zero_Filled
wire [32-1:0] ZF_out;
//ALU
wire [32-1:0] aluSrc2;
wire [32-1:0] result_alu;
wire zero;
wire overflow;
//Shifter
wire [32-1:0] result_shifter;

wire [32-1:0] Adder1_o;
wire [5-1:0]  Mux1_o;
wire [5-1:0]  ra;
wire          jal;
wire [32-1:0] Mux2_o;

wire Branch;
wire Branchtype;
wire Jump;
wire Memwrite;
wire Memread;
wire Memtoreg;
wire Jr;

wire [32-1:0] address;
wire [32-1:0] Mem_o;
wire [32-1:0] Ashifted;
wire [32-1:0] jump_address;
wire [32-1:0] Adder2_o;
wire not_zero;
wire mux_branch_result;
wire pc_src;
wire [32-1:0] branch_mux_o;
wire [32-1:0] jump_mux_o;

//Bonus Internal Signals
wire [5-1:0] shamt;
wire shift_v;

//modules
Program_Counter PC(
        .clk_i(clk_i),      
	    .rst_n(rst_n),     
	    .pc_in_i(pc_in) ,   
	    .pc_out_o(pc_out) 
	    );
	
Adder Adder1(
        .src1_i(pc_out),     
	    .src2_i(32'd4),
	    .sum_o(Adder1_o)    
	    );
		
Adder Adder2(
		.src1_i(Adder1_o),
		.src2_i(Ashifted),
		.sum_o(Adder2_o)
		);
	
Instr_Memory IM(
        .pc_addr_i(pc_out),  
	    .instr_o(instr)    
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
		
Reg_File RF(
        .clk_i(clk_i),      
	    .rst_n(rst_n) ,     
        .RSaddr_i(instr[25:21]) ,  
        .RTaddr_i(instr[20:16]) ,  
        .RDaddr_i(rd_addr) ,  
        .RDdata_i(rd_data)  , 
        .RegWrite_i(reg_write),
        .RSdata_o(rs_data) ,  
        .RTdata_o(rt_data)   
        );
	
Decoder Decoder(
        .instr_op_i(instr[31:26]), 
	    .RegWrite_o(reg_write), 
	    .ALUOp_o(alu_op),   
	    .ALUSrc_o(alu_src),   
	    .RegDst_o(reg_dst),
        .Branch_o(Branch),
        .Branch_type(Branchtype),
		.Jump_o(Jump),
        .MemRead_o(Memread),
		.MemWrite_o(Memwrite),
        .MemtoReg_o(Memtoreg),
        .Jal_reg_o(jal)   
		
		);

ALU_Ctrl AC(
        .funct_i(instr[5:0]),   
        .ALUOp_i(alu_op),   
        .ALU_operation_o(alu_operation),
		.FURslt_o(FURslt),
		.Jr(Jr)
        );
	
Sign_Extend SE(
        .data_i(instr[15:0]),
        .data_o(SE_out)
        );

Zero_Filled ZF(
        .data_i(instr[15:0]),
        .data_o(ZF_out)
        );
		
Mux2to1 #(.size(32)) ALU_src2Src(
        .data0_i(rt_data),
        .data1_i(SE_out),
        .select_i(alu_src),
        .data_o(aluSrc2)
        );	
		
ALU ALU(
		.aluSrc1(rs_data),
	    .aluSrc2(aluSrc2),
	    .ALU_operation_i(alu_operation),
		.result(result_alu),
		.zero(zero),
		.overflow(overflow)
	    );
		
Data_Memory DM(
        .clk_i(clk_i),
        .addr_i(address),
        .data_i(rt_data),
        .MemRead_i(Memread),
        .MemWrite_i(Memwrite),
        .data_o(Mem_o)
        );
		
Shifter shifter( 
		.result(result_shifter), 
		.leftRight(alu_operation[3]), 
		.shamt(instr[10:6]),
		.sftSrc(aluSrc2) 
		);
//see ALU_Ctrl.v , 
//(funct_i == 0 || funct_i == 6)? 4'b0100: 4'b0000 //According to SPEC, alu_operation[2]=1 when shift left(funct = 0 | 6);		
		
Mux3to1 #(.size(32)) RDdata_Source(
        .data0_i(result_alu),
        .data1_i(result_shifter),
		.data2_i(ZF_out),
        .select_i(FURslt),
        .data_o(address)
        );			

endmodule



