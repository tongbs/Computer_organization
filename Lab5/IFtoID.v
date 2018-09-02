module IFtoID(clk, rst, PC, instruction, PC_o, instr_o);

input clk;
input rst;

input [32-1:0]PC;
input [32-1:0]instruction;

output reg [32-1:0]PC_o;
output reg [32-1:0]instr_o;

always @(posedge clk) begin
	if(rst == 0) begin
		PC_o <= 0;
		instr_o <= 0;
	end
	else begin
		PC_o <= PC;
		instr_o <= instruction;
	end
end

endmodule