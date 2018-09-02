module Simple_Single_CPU( clk_i, rst_n );

//I/O port
input         clk_i;
input         rst_n;

//Internal Signles
wire[32-1:0] instruction;
wire[32-1:0] pc_output;
wire[32-1:0] pc_input;
wire reg_dst;
wire[5-1:0] write_reg;
wire[32-1:0] rd_data;
wire RegWrite;
wire[32-1:0] RSdata;
wire[32-1:0] RTdata;
wire[3-1:0] ALUOp;
wire ALUSrc;
wire [4-1:0] ALU_operation;
wire [2-1:0] FURslt;
wire[32-1:0] SE_data;
wire[32-1:0] ZF_data;
wire[32-1:0] ALU_result;
wire[32-1:0] aluSrc2;
wire zero;
wire overflow;
wire[32-1:0] shifter_result;
wire[5-1:0] shift_amount;
wire shift_exe;


//modules
Program_Counter PC(
        .clk_i(clk_i),      
	    .rst_n(rst_n),     
	    .pc_in_i(pc_input) ,   
	    .pc_out_o(pc_output) 
	    );
	
Adder Adder1(
        .src1_i(pc_output),     
	    .src2_i(4),
	    .sum_o(pc_input)    
	    );
	
Instr_Memory IM(
        .pc_addr_i(pc_output),  
	    .instr_o(instruction)    
	    );

Mux2to1 #(.size(5)) Mux_Write_Reg(
        .data0_i(instruction[20:16]),
        .data1_i(instruction[15:11]),
        .select_i(reg_dst),
        .data_o(write_reg)
        );	
		
Reg_File RF(
        .clk_i(clk_i),      
	    .rst_n(rst_n) ,     
        .RSaddr_i(instruction[25:21]) ,  
        .RTaddr_i(instruction[20:16]) ,  
        .RDaddr_i(write_reg) ,  
        .RDdata_i(rd_data)  , 
        .RegWrite_i(RegWrite),
        .RSdata_o(RSdata) ,  
        .RTdata_o(RTdata)   
        );
	
Decoder Decoder(
        .instr_op_i(instruction[31:26]), 
	    .RegWrite_o(RegWrite), 
	    .ALUOp_o(ALUOp),   
	    .ALUSrc_o(ALUSrc),   
	    .RegDst_o(reg_dst)   
		);

ALU_Ctrl AC(
        .funct_i(instruction[5:0]),   
        .ALUOp_i(ALUOp),   
        .ALU_operation_o(ALU_operation),
		.FURslt_o(FURslt)
        );
	
Sign_Extend SE(
        .data_i(instruction[15:0]),
        .data_o(SE_data)
        );

Zero_Filled ZF(
        .data_i(instruction[15:0]),
        .data_o(ZF_data)
        );
		
Mux2to1 #(.size(32)) ALU_src2Src(
        .data0_i(RTdata),
        .data1_i(SE_data),
        .select_i(ALUSrc),
        .data_o(aluSrc2)
        );	
		
ALU ALU(
		.aluSrc1(RSdata),
	    .aluSrc2(aluSrc2),
	    .ALU_operation_i(ALU_operation),
		.result(ALU_result),
		.zero(zero),
		.overflow(overflow)
	    );
		
Shifter shifter( 
		.result(shifter_result), 
		.leftRight(ALU_operation[3]),
		.shamt(shift_amount),
		.sftSrc(aluSrc2) 
		);
		
shifter_control SC(
		.funct_i(instruction[5:0]),
		.shifter_exe(shift_exe)
		);
		
Mux2to1 #(.size(5)) shifetr_control(
		.data0_i(RSdata[4:0]),
		.data1_i(instruction[10:6]),
		.select_i(shift_exe),
		.data_o(shift_amount)
		);
		
Mux3to1 #(.size(32)) RDdata_Source(
        .data0_i(ALU_result),
        .data1_i(shifter_result),
		.data2_i(ZF_data),
        .select_i(FURslt),
        .data_o(rd_data)
        );			

endmodule



