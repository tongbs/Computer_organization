module IDtoEX(clk, rst, ALU_i, shamt, ZF_data, RegWrite, MemtoReg, Branch, BranchType, MemRead, MemWrte, ALUSrc, ALUOp, RegDst, PC_i, RSdata, RTdata, SE_data, RS, RT, ALU_o, shamt_o, ZF_data_o, RegWrite_o, MemtoReg_o, Branch_o, BranchType_o, MemRead_o, MemWrte_o, ALUSrc_o, ALUOp_o, RegDst_o, PC_o, RSdata_o, RTdata_o, SE_data_o, RS_o, RT_o);

input clk;
input rst;
input RegWrite;
input MemtoReg;
input [32-1:0]PC_i;
input [32-1:0]RSdata;
input [32-1:0]RTdata;
input [32-1:0]SE_data;
input [32-1:0]ZF_data;
input [6-1:0]ALU_i;
input [5-1:0]shamt;
input [5-1:0]RS;
input [5-1:0]RT;


input Branch;
input BranchType;
input MemRead;
input MemWrte;
input ALUSrc;
input [3-1:0]ALUOp;
input RegDst;


output reg RegWrite_o;
output reg MemtoReg_o;
output reg MemRead_o;
output reg MemWrte_o;
output reg ALUSrc_o;
output reg [3-1:0]ALUOp_o;
output reg RegDst_o;
output reg [32-1:0]PC_o;
output reg [32-1:0]RSdata_o;
output reg [32-1:0]RTdata_o;
output reg [32-1:0]SE_data_o;
output reg [32-1:0]ZF_data_o;

output reg Branch_o;
output reg BranchType_o;
output reg [6-1:0]ALU_o;
output reg [5-1:0]shamt_o;
output reg [5-1:0]RS_o;
output reg [5-1:0]RT_o;

always @(posedge clk) begin
	if(rst == 0) begin
		RegWrite_o <= 0;
		MemtoReg_o <= 0;
		Branch_o <= 0;
		BranchType_o <= 0;
		MemRead_o <= 0;
		MemWrte_o <= 0;
		ALUSrc_o <= 0;
		ALUOp_o <= 0;
		RegDst_o <= 0;
		ALU_o <= 0;
		shamt_o <= 0;
		PC_o <= 0;
		RSdata_o <= 0;
		RTdata_o <= 0;
		SE_data_o <= 0;
		ZF_data_o <= 0;
		RS_o <= 0;
		RT_o <= 0;
	end
	else begin
		RegWrite_o <= RegWrite;
		MemtoReg_o <= MemtoReg;
		Branch_o <= Branch;
		BranchType_o <= BranchType;
		MemRead_o <= MemRead;
		MemWrte_o <= MemWrte;
		ALUSrc_o <= ALUSrc;
		ALUOp_o <= ALUOp;
		RegDst_o <= RegDst;
		PC_o <= PC_i;
		RSdata_o <= RSdata;
		RTdata_o <= RTdata;
		SE_data_o <= SE_data;
		ZF_data_o <= ZF_data;
		ALU_o <= ALU_i;
		shamt_o <= shamt;
		RS_o <= RS;
		RT_o <= RT;
	end
end

endmodule