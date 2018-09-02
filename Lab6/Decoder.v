module Decoder( instr_op_i, RegWrite_o,	ALUOp_o, ALUSrc_o, RegDst_o ,Branch_o,BranchType_o,Jump_o,MemRead_o,MemWrite_o,MemtoReg_o);
  
//I/O ports
input	[6-1:0] instr_op_i;

output			RegWrite_o;
output	[3-1:0] ALUOp_o;
output			ALUSrc_o;
output			RegDst_o;
 
//Internal Signals
wire	[3-1:0] ALUOp_o;
wire			ALUSrc_o;
wire			RegWrite_o;
wire			RegDst_o;

//lab4
output Branch_o,BranchType_o,Jump_o,MemRead_o,MemWrite_o,MemtoReg_o;
wire Branch_o,BranchType_o,Jump_o,MemRead_o,MemWrite_o,MemtoReg_o;

//Main function
/*your code here*/
	assign RegWrite_o = (instr_op_i == 6'b111111 || // R type
							instr_op_i == 6'b110111 || // addi
							instr_op_i == 6'b110000 || // lui
							instr_op_i == 6'b100001 || // lw
							instr_op_i == 6'b100111);  // jal
	
	assign ALUOp_o = (instr_op_i == 6'b111111) ? 3'b010 :	 // R type
					  (instr_op_i == 6'b110111) ? 3'b100 :  // addi
					  (instr_op_i == 6'b100010) ? 3'b101 :  // j
					  (instr_op_i == 6'b100001 || instr_op_i == 6'b100011) ? 3'b000 : //lw sw
					  (instr_op_i == 6'b111011) ? 3'b001 :  // beq
					  (instr_op_i == 6'b100101 || instr_op_i == 6'b101101) ? 3'b110 :  // bne bnez
					  (instr_op_i == 6'b100110 || instr_op_i == 6'b110001) ? 3'b011 : 3'b101; // blt bgez // lui
	
	assign ALUSrc_o = (instr_op_i == 6'b110111 || instr_op_i == 6'b001111 || instr_op_i == 6'b100001 || instr_op_i == 6'b100011) ? 1 : // addi lui lw sw
						(instr_op_i == 6'b110001) ? 2 : 0; // bgez
					  
	assign RegDst_o = (instr_op_i == 6'b111111) ? 1 : 	  // R type
						(instr_op_i == 6'b100111) ? 2 : 0; // jal
					  
	assign Branch_o = (instr_op_i == 6'b111011 || // beq
						 instr_op_i == 6'b100101 || // bne
						 instr_op_i == 6'b101101 || //bnez
						 instr_op_i == 6'b100110 || // blt
						 instr_op_i == 6'b110001);  // bgez

	assign BranchType_o = (instr_op_i == 6'b111011) ? 0 : // beq = 0
					 (instr_op_i == 6'b100101 || instr_op_i == 6'b101101) ? 1 : // bne bnez = 1
					 (instr_op_i == 6'b100110) ? 2 : 3; //blt = 2 bgez = 3

	assign Jump_o = (instr_op_i == 6'b100010 || // j
					  instr_op_i == 6'b100111); // jal
					 
	assign MemWrite_o = (instr_op_i == 6'b100011) ? 1 : 0; // sw

	assign MemRead_o = (instr_op_i == 6'b100001) ? 1 : 0;  // lw

	assign MemtoReg_o = (instr_op_i == 6'b100001) ? 1 :    // lw
						  (instr_op_i == 6'b100111) ? 2 : 0; // jal

	
endmodule
   