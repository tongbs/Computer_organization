module ALU_Ctrl( funct_i, ALUOp_i, ALU_operation_o, FURslt_o);

//I/O ports 
input      [6-1:0] funct_i;
input      [3-1:0] ALUOp_i;

output     [4-1:0] ALU_operation_o;  
output     [2-1:0] FURslt_o;
     
//Internal Signals
wire		[4-1:0] ALU_operation_o;
wire		[2-1:0] FURslt_o;

//Main function
/*your code here*/
	assign ALU_operation_o=(ALUOp_i==3'b010)?((funct_i==18)?4'b0010:
															((funct_i==16)?4'b0110:
															((funct_i==20)?4'b0000:
															((funct_i==22)?4'b0001:
															((funct_i==21)?4'b1100:
															((funct_i==32)?4'b0111:
															((funct_i==0)?4'b1000:4'b0001))))))): //*****
									((ALUOp_i==3'b100)?4'b0010:(ALUOp_i==3'b101)?4'b0000:
									(ALUOp_i==3'b000)?4'b0010:4'b0110);
	assign FURslt_o=(ALUOp_i==3'b010)?((funct_i==0||funct_i==2)?2'b01:2'b00):
							((ALUOp_i==3'b101)?2'b10:2'b00);
							

endmodule     
