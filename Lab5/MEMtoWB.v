module MEMtoWB(clk, rst, RegWrite, MemtoReg, Result, MemData, target_data, RegWrite_o, MemtoReg_o, Result_o, MemData_o, target_data_o);

input clk;
input rst;
input RegWrite;
input MemtoReg;



input [32-1:0]Result;
input [32-1:0]MemData;
input [5-1:0]target_data;

output reg RegWrite_o;
output reg MemtoReg_o;


output reg [32-1:0]Result_o;
output reg [32-1:0]MemData_o;
output reg [5-1:0]target_data_o;

always @(posedge clk) begin
	if(rst == 0) begin
		RegWrite_o <= 0;
		MemtoReg_o <= 0;
		Result_o <= 0;
		MemData_o <= 0;
		target_data_o <= 0;
	end
	else begin
		RegWrite_o <= RegWrite;
		MemtoReg_o <= MemtoReg;
		Result_o <= Result;
		MemData_o <= MemData;
		target_data_o <= target_data;
	end
end

endmodule