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
wire invertA;
wire invertB;
wire [2-1:0]operation;
assign invertA=ALU_operation_i[3];
assign invertB=ALU_operation_i[2];
assign operation[0]=ALU_operation_i[0];
assign operation[1]=ALU_operation_i[1];
wire [31:0] carry;
wire Set;
wire carry1; //put A31 carryOut

assign carry1=(invertB==1)?1:0;  
assign Set=aluSrc1[31]^(~aluSrc2[31])^carry[30];
	
assign zero=(result==0)?1:0;
assign overflow = carry[30]^carry[31];

	ALU_1bit A0( .result(result[0]),.carryOut(carry[0]),.a(aluSrc1[0]),.b(aluSrc2[0]),.invertA(invertA),.invertB(invertB),.operation(operation),.carryIn(carry1),.less(Set));
	ALU_1bit A1( .result(result[1]),.carryOut(carry[1]),.a(aluSrc1[1]),.b(aluSrc2[1]),.invertA(invertA),.invertB(invertB),.operation(operation),.carryIn(carry[0]),.less(0));
    ALU_1bit A2( .result(result[2]),.carryOut(carry[2]),.a(aluSrc1[2]),.b(aluSrc2[2]),.invertA(invertA),.invertB(invertB),.operation(operation),.carryIn(carry[1]),.less(0));
	ALU_1bit A3( .result(result[3]),.carryOut(carry[3]),.a(aluSrc1[3]),.b(aluSrc2[3]),.invertA(invertA),.invertB(invertB),.operation(operation),.carryIn(carry[2]),.less(0));  
	ALU_1bit A4( .result(result[4]),.carryOut(carry[4]),.a(aluSrc1[4]),.b(aluSrc2[4]),.invertA(invertA),.invertB(invertB),.operation(operation),.carryIn(carry[3]),.less(0));
	ALU_1bit A5( .result(result[5]),.carryOut(carry[5]),.a(aluSrc1[5]),.b(aluSrc2[5]),.invertA(invertA),.invertB(invertB),.operation(operation),.carryIn(carry[4]),.less(0));
	ALU_1bit A6( .result(result[6]),.carryOut(carry[6]),.a(aluSrc1[6]),.b(aluSrc2[6]),.invertA(invertA),.invertB(invertB),.operation(operation),.carryIn(carry[5]),.less(0));
	ALU_1bit A7( .result(result[7]),.carryOut(carry[7]),.a(aluSrc1[7]),.b(aluSrc2[7]),.invertA(invertA),.invertB(invertB),.operation(operation),.carryIn(carry[6]),.less(0));
	ALU_1bit A8( .result(result[8]),.carryOut(carry[8]),.a(aluSrc1[8]),.b(aluSrc2[8]),.invertA(invertA),.invertB(invertB),.operation(operation),.carryIn(carry[7]),.less(0));
	ALU_1bit A9( .result(result[9]),.carryOut(carry[9]),.a(aluSrc1[9]),.b(aluSrc2[9]),.invertA(invertA),.invertB(invertB),.operation(operation),.carryIn(carry[8]),.less(0));
	ALU_1bit A10( .result(result[10]),.carryOut(carry[10]),.a(aluSrc1[10]),.b(aluSrc2[10]),.invertA(invertA),.invertB(invertB),.operation(operation),.carryIn(carry[9]),.less(0));
	ALU_1bit A11( .result(result[11]),.carryOut(carry[11]),.a(aluSrc1[11]),.b(aluSrc2[11]),.invertA(invertA),.invertB(invertB),.operation(operation),.carryIn(carry[10]),.less(0));
	ALU_1bit A12( .result(result[12]),.carryOut(carry[12]),.a(aluSrc1[12]),.b(aluSrc2[12]),.invertA(invertA),.invertB(invertB),.operation(operation),.carryIn(carry[11]),.less(0));
	ALU_1bit A13( .result(result[13]),.carryOut(carry[13]),.a(aluSrc1[13]),.b(aluSrc2[13]),.invertA(invertA),.invertB(invertB),.operation(operation),.carryIn(carry[12]),.less(0));
	ALU_1bit A14( .result(result[14]),.carryOut(carry[14]),.a(aluSrc1[14]),.b(aluSrc2[14]),.invertA(invertA),.invertB(invertB),.operation(operation),.carryIn(carry[13]),.less(0));
	ALU_1bit A15( .result(result[15]),.carryOut(carry[15]),.a(aluSrc1[15]),.b(aluSrc2[15]),.invertA(invertA),.invertB(invertB),.operation(operation),.carryIn(carry[14]),.less(0));
	ALU_1bit A16( .result(result[16]),.carryOut(carry[16]),.a(aluSrc1[16]),.b(aluSrc2[16]),.invertA(invertA),.invertB(invertB),.operation(operation),.carryIn(carry[15]),.less(0));
	ALU_1bit A17( .result(result[17]),.carryOut(carry[17]),.a(aluSrc1[17]),.b(aluSrc2[17]),.invertA(invertA),.invertB(invertB),.operation(operation),.carryIn(carry[16]),.less(0));
	ALU_1bit A18( .result(result[18]),.carryOut(carry[18]),.a(aluSrc1[18]),.b(aluSrc2[18]),.invertA(invertA),.invertB(invertB),.operation(operation),.carryIn(carry[17]),.less(0));
	ALU_1bit A19( .result(result[19]),.carryOut(carry[19]),.a(aluSrc1[19]),.b(aluSrc2[19]),.invertA(invertA),.invertB(invertB),.operation(operation),.carryIn(carry[18]),.less(0));
	ALU_1bit A20( .result(result[20]),.carryOut(carry[20]),.a(aluSrc1[20]),.b(aluSrc2[20]),.invertA(invertA),.invertB(invertB),.operation(operation),.carryIn(carry[19]),.less(0));
	ALU_1bit A21( .result(result[21]),.carryOut(carry[21]),.a(aluSrc1[21]),.b(aluSrc2[21]),.invertA(invertA),.invertB(invertB),.operation(operation),.carryIn(carry[20]),.less(0));
	ALU_1bit A22( .result(result[22]),.carryOut(carry[22]),.a(aluSrc1[22]),.b(aluSrc2[22]),.invertA(invertA),.invertB(invertB),.operation(operation),.carryIn(carry[21]),.less(0));
	ALU_1bit A23( .result(result[23]),.carryOut(carry[23]),.a(aluSrc1[23]),.b(aluSrc2[23]),.invertA(invertA),.invertB(invertB),.operation(operation),.carryIn(carry[22]),.less(0));
	ALU_1bit A24( .result(result[24]),.carryOut(carry[24]),.a(aluSrc1[24]),.b(aluSrc2[24]),.invertA(invertA),.invertB(invertB),.operation(operation),.carryIn(carry[23]),.less(0));
	ALU_1bit A25( .result(result[25]),.carryOut(carry[25]),.a(aluSrc1[25]),.b(aluSrc2[25]),.invertA(invertA),.invertB(invertB),.operation(operation),.carryIn(carry[24]),.less(0));
	ALU_1bit A26( .result(result[26]),.carryOut(carry[26]),.a(aluSrc1[26]),.b(aluSrc2[26]),.invertA(invertA),.invertB(invertB),.operation(operation),.carryIn(carry[25]),.less(0));
	ALU_1bit A27( .result(result[27]),.carryOut(carry[27]),.a(aluSrc1[27]),.b(aluSrc2[27]),.invertA(invertA),.invertB(invertB),.operation(operation),.carryIn(carry[26]),.less(0));
	ALU_1bit A28( .result(result[28]),.carryOut(carry[28]),.a(aluSrc1[28]),.b(aluSrc2[28]),.invertA(invertA),.invertB(invertB),.operation(operation),.carryIn(carry[27]),.less(0));
	ALU_1bit A29( .result(result[29]),.carryOut(carry[29]),.a(aluSrc1[29]),.b(aluSrc2[29]),.invertA(invertA),.invertB(invertB),.operation(operation),.carryIn(carry[28]),.less(0));
	ALU_1bit A30( .result(result[30]),.carryOut(carry[30]),.a(aluSrc1[30]),.b(aluSrc2[30]),.invertA(invertA),.invertB(invertB),.operation(operation),.carryIn(carry[29]),.less(0));
	ALU_1bit A31( .result(result[31]),.carryOut(carry[31]),.a(aluSrc1[31]),.b(aluSrc2[31]),.invertA(invertA),.invertB(invertB),.operation(operation),.carryIn(carry[30]),.less(0));

endmodule
