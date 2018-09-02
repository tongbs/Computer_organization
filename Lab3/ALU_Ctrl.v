module ALU_Ctrl( funct_i, ALUOp_i, ALU_operation_o, FURslt_o );

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
assign ALU_operation_o = (ALUOp_i[2:0]==3'b010)?
                         (funct_i[5:0]==6'b010010)?4'b0010://ADD
						 (funct_i[5:0]==6'b010000)?4'b0110://SUB
						 (funct_i[5:0]==6'b010100)?4'b0000://AND
						 (funct_i[5:0]==6'b010110)?4'b0001://OR
						 (funct_i[5:0]==6'b010101)?4'b1100://NOR
						 (funct_i[5:0]==6'b100000)?4'b0111://SLT
						 (funct_i[5:0]==6'b000000||funct_i[5:0]==6'b000110)?4'b1000:4'b0000:4'b0010;
						 
assign FURslt_o = (ALUOp_i[2:0] == 3'b010)?((funct_i[5:0]==6'b000000||funct_i[5:0]==6'b000010)?2'b01:2'b00):(ALUOp_i[2:0]==3'b100)?2'b00:2'b10;
						 


endmodule     
