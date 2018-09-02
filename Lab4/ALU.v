module ALU( aluSrc1, aluSrc2, ALU_operation_i, result, zero, overflow );

//I/O ports 
input	[32-1:0] aluSrc1;
input	[32-1:0] aluSrc2;
input	 [4-1:0] ALU_operation_i;

output	[32-1:0] result;
output			 zero;
output			 overflow;

//Internal Signals
wire			 zero;
wire			 overflow;
wire	[32-1:0] result;

//Main function
/*your code here*/
assign zero = (result==0);

assign result = (ALU_operation_i==4'b0000)?(aluSrc1+aluSrc2):
	(ALU_operation_i==4'b0111)?(aluSrc1+aluSrc2):
	(ALU_operation_i==4'b0001)?(aluSrc1-aluSrc2):
	(ALU_operation_i==4'b0010)?(aluSrc1&aluSrc2):
	(ALU_operation_i==4'b0011)?(aluSrc1|aluSrc2):
	(ALU_operation_i==4'b0100)?~(aluSrc1|aluSrc2):
	(ALU_operation_i==4'b0101)?((aluSrc1[31]==0&&aluSrc2[31]==1||aluSrc1[31]==1&&aluSrc2[31]==0)?(aluSrc1>aluSrc2?1:0):(aluSrc1<aluSrc2)?1:0):
	(ALU_operation_i==4'b1001)?(aluSrc1<<16):
	(ALU_operation_i==4'b1010 && (aluSrc1-0)>=0)?0:1;

assign overflow=((aluSrc1[31]==0&&aluSrc2[31]==0&&result[31]==1)||(aluSrc1[31]==1&&aluSrc2[31]==1&&result[31]==0))?1:0;

endmodule
