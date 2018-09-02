module ALU_Ctrl( funct_i, ALUOp_i, ALU_operation_o, FURslt_o, Jr );

//I/O ports 
input      [6-1:0] funct_i;
input      [3-1:0] ALUOp_i;

output     [4-1:0] ALU_operation_o;  
output     [2-1:0] FURslt_o;
output             Jr;

//Internal Signals
wire		[4-1:0] ALU_operation_o;
wire		[2-1:0] FURslt_o;
wire                Jr;

//Main function
/*your code here*/
assign	ALU_operation_o = ( ALUOp_i==2 && funct_i == 6'b010010)?4'b0000:
	( ALUOp_i == 3'b010 && funct_i == 6'b010000)?4'b0001: 
	( ALUOp_i == 3'b010 && funct_i == 6'b010100)?4'b0010: 
	( ALUOp_i == 3'b010 && funct_i == 6'b010110)?4'b0011: 
	( ALUOp_i == 3'b010 && funct_i == 6'b010101)?4'b0100: 
	( ALUOp_i == 3'b010 && funct_i == 6'b100000)?4'b0101: 
	( ALUOp_i == 3'b010 && funct_i == 6'b000000)?4'b1000: 
	( ALUOp_i == 3'b010 && funct_i == 6'b000010)?4'b0110: 
	( ALUOp_i == 3'b100 || ALUOp_i == 3'b000)?4'b0111:  	   
	( ALUOp_i == 3'b101)? 4'b1001:						   
	( ALUOp_i == 3'b001)? 4'b0001:						   
	( ALUOp_i == 3'b110)? 4'b0001:						   
	( ALUOp_i == 3'b111)? 4'b0101:4'b1010;
	
assign	FURslt_o = ( ALUOp_i == 3'b010 && funct_i == 6'b010010)?0:
	( ALUOp_i == 3'b010 && funct_i == 6'b010000)?0:
	( ALUOp_i == 3'b010 && funct_i == 6'b010100)?0:
	( ALUOp_i == 3'b010 && funct_i == 6'b010110)?0:
	( ALUOp_i == 3'b010 && funct_i == 6'b010101)?0:
	( ALUOp_i == 3'b010 && funct_i == 6'b100000)?0:
	( ALUOp_i == 3'b010 && funct_i == 6'b000000)?1:
	( ALUOp_i == 3'b010 && funct_i == 6'b000010)?1:
	( ALUOp_i == 3'b100 || ALUOp_i == 3'b000)?0:2;

assign Jr = (ALUOp_i == 3'b010 && funct_i ==6'b001000) ? 1 : 0;

endmodule     
