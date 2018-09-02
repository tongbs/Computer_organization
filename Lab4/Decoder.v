module Decoder( instr_op_i, RegWrite_o,	ALUOp_o, ALUSrc_o, RegDst_o, Branch_o,Branch_type,Jump_o,MemRead_o,MemWrite_o,MemtoReg_o,Jal_reg_o );
     
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

output          Branch_o;
output   		Branch_type;
output          Jump_o;
output          MemRead_o;
output          MemWrite_o;
output          MemtoReg_o;
output          Jal_reg_o;

wire            Jump_o;
wire            Branch_o;
wire            Branch_type;
wire            MemWrite_o;
wire            MemRead_o;
wire            MemtoReg_o;
wire            Jal_reg_o;

//Main function
/*your code here*/
/*assign RegWrite_o = 1; //In LAB3, all instructions have to write data into register*/
assign  RegWrite_o = (instr_op_i == 6'b100011 || instr_op_i == 6'b111011 || instr_op_i == 6'b100101 || instr_op_i == 6'b100010 || instr_op_i == 6'b100110 || instr_op_i == 6'b110001)? 0:1;
//sw beq bne j jal blt bnez bgez

/*assign ALUOp_o =  (instr_op_i == 6'b111111)? 3'b010: //R-type
				  (instr_op_i == 6'b110111)? 3'b100: //addi
				  3'b101; //LUI*/
assign  ALUOp_o = (instr_op_i == 6'b100001 || instr_op_i == 6'b100011)?3'b000:	//lw sw
				  (instr_op_i == 6'b111011)? 3'b001:	//beq
				  (instr_op_i == 6'b100101)? 3'b110:	//bne bnez
				  (instr_op_i == 6'b100110)? 3'b111:	//blt
				  (instr_op_i == 6'b110001)? 3'b011:	//bgez
				  (instr_op_i == 6'b111111)? 3'b010:	//R type Jr (sll srl sllv srlv)
				  (instr_op_i == 6'b110111)? 3'b100:	//addi
				                             3'b101;	//lui
/*assign ALUSrc_o = (instr_op_i == 6'b111111)? 0:1; //R-type's ALU input2 = read data2*/
assign  ALUSrc_o = (instr_op_i == 6'b100001)? 1:	 //lw
				   (instr_op_i == 6'b100011)? 1:	 //sw
				   (instr_op_i == 6'b110111)? 1:	 //addi
				   (instr_op_i == 6'b110000)? 1:	 //lui
				   (instr_op_i == 6'b110001)? 1:	 //bgez load 1
				     						  0;											   
/*assign RegDst_o = (instr_op_i == 6'b111111)? 1:0; //R-type write data into 'rd' */
assign RegDst_o= (instr_op_i==6'b111111) ? 1 : 0;

assign	Branch_o = (instr_op_i == 6'b111011 || instr_op_i == 6'b100101 || instr_op_i == 6'b100110 || instr_op_i == 6'b110001)? 1:0;

assign Branch_type = (instr_op_i == 6'b100101 || instr_op_i == 6'b100110)? 1 :0;

assign Jump_o = (instr_op_i == 6'b100010 ||instr_op_i == 6'b100111)? 1 : 0;

assign MemWrite_o = instr_op_i == 6'b100011 ? 1 : 0;

assign MemRead_o = instr_op_i == 6'b100001 ? 1 : 0;

assign MemtoReg_o = instr_op_i == 6'b100001 ? 1 : 0;

assign Jal_reg_o = instr_op_i == 6'b100111 ? 1 : 0;

endmodule

   