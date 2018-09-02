module EXtoMEM(clk, rst, RegWrite, MemtoReg, Branch, MemRead, MemWrte, Zero, PC_i, Result, RT_data, target_data, RegWrite_o, MemtoReg_o, Branch_o, MemRead_o, MemWrte_o, Zero_o, PC_o, Result_o, RT_data_o, target_data_o);

input clk;
input rst;
input RegWrite;
input MemtoReg;
input Branch;
input MemRead;
input MemWrte;
input Zero;



input [32-1:0]PC_i;
input [32-1:0]Result;
input [32-1:0]RT_data;
input [5-1:0]target_data;
////////////////////////////////////////////////////////////
output reg RegWrite_o;
output reg MemtoReg_o;
output reg Branch_o;
output reg MemRead_o;
output reg MemWrte_o;
output reg Zero_o;



output reg [32-1:0]PC_o;
output reg [32-1:0]Result_o;
output reg [32-1:0]RT_data_o;
output reg [5-1:0]target_data_o;

always @(posedge clk) begin
	if(rst == 0) begin
		RegWrite_o <= 0;
		MemtoReg_o <= 0;
		Branch_o <= 0;
		MemRead_o <= 0;
		MemWrte_o <= 0;
		Zero_o <= 0;
		PC_o <= 0;
		Result_o <= 0;
		RT_data_o <= 0;
		target_data_o <= 0;
	end
	else begin
		RegWrite_o <= RegWrite;
		MemtoReg_o <= MemtoReg;
		Branch_o <= Branch;
		MemRead_o <= MemRead;
		MemWrte_o <= MemWrte;
		Zero_o <= Zero;
		PC_o <= PC_i;
		Result_o <= Result;
		RT_data_o <= RT_data;
		target_data_o <= target_data;
	end
end

endmodule