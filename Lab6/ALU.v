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
	wire invertA,invertB;
	wire[1:0] operation;
	wire[31:0] carryin;
	wire set,carryout;
	wire high;
	
	assign {invertA,invertB,operation}=ALU_operation_i;
	
	assign carryin[0]=(invertB==1&&(operation==2||operation==3))?1:0;
	//ALU_1bit(result,carryOut,a,b,invertA,invertB,operation,carryIn,less); 
	ALU_1bit a0(result[0],carryin[1],aluSrc1[0],aluSrc2[0],invertA,invertB,operation,carryin[0],set);
	ALU_1bit a1(result[1],carryin[2],aluSrc1[1],aluSrc2[1],invertA,invertB,operation,carryin[1],0);
	ALU_1bit a2(result[2],carryin[3],aluSrc1[2],aluSrc2[2],invertA,invertB,operation,carryin[2],0);
	ALU_1bit a3(result[3],carryin[4],aluSrc1[3],aluSrc2[3],invertA,invertB,operation,carryin[3],0);
	ALU_1bit a4(result[4],carryin[5],aluSrc1[4],aluSrc2[4],invertA,invertB,operation,carryin[4],0);
	ALU_1bit a5(result[5],carryin[6],aluSrc1[5],aluSrc2[5],invertA,invertB,operation,carryin[5],0);
	ALU_1bit a6(result[6],carryin[7],aluSrc1[6],aluSrc2[6],invertA,invertB,operation,carryin[6],0);
	ALU_1bit a7(result[7],carryin[8],aluSrc1[7],aluSrc2[7],invertA,invertB,operation,carryin[7],0);
	ALU_1bit a8(result[8],carryin[9],aluSrc1[8],aluSrc2[8],invertA,invertB,operation,carryin[8],0);
	ALU_1bit a9(result[9],carryin[10],aluSrc1[9],aluSrc2[9],invertA,invertB,operation,carryin[9],0);
	ALU_1bit a10(result[10],carryin[11],aluSrc1[10],aluSrc2[10],invertA,invertB,operation,carryin[10],0);
	ALU_1bit a11(result[11],carryin[12],aluSrc1[11],aluSrc2[11],invertA,invertB,operation,carryin[11],0);
	ALU_1bit a12(result[12],carryin[13],aluSrc1[12],aluSrc2[12],invertA,invertB,operation,carryin[12],0);
	ALU_1bit a13(result[13],carryin[14],aluSrc1[13],aluSrc2[13],invertA,invertB,operation,carryin[13],0);
	ALU_1bit a14(result[14],carryin[15],aluSrc1[14],aluSrc2[14],invertA,invertB,operation,carryin[14],0);
	ALU_1bit a15(result[15],carryin[16],aluSrc1[15],aluSrc2[15],invertA,invertB,operation,carryin[15],0);
	ALU_1bit a16(result[16],carryin[17],aluSrc1[16],aluSrc2[16],invertA,invertB,operation,carryin[16],0);
	ALU_1bit a17(result[17],carryin[18],aluSrc1[17],aluSrc2[17],invertA,invertB,operation,carryin[17],0);
	ALU_1bit a18(result[18],carryin[19],aluSrc1[18],aluSrc2[18],invertA,invertB,operation,carryin[18],0);
	ALU_1bit a19(result[19],carryin[20],aluSrc1[19],aluSrc2[19],invertA,invertB,operation,carryin[19],0);
	ALU_1bit a20(result[20],carryin[21],aluSrc1[20],aluSrc2[20],invertA,invertB,operation,carryin[20],0);
	ALU_1bit a21(result[21],carryin[22],aluSrc1[21],aluSrc2[21],invertA,invertB,operation,carryin[21],0);
	ALU_1bit a22(result[22],carryin[23],aluSrc1[22],aluSrc2[22],invertA,invertB,operation,carryin[22],0);
	ALU_1bit a23(result[23],carryin[24],aluSrc1[23],aluSrc2[23],invertA,invertB,operation,carryin[23],0);
	ALU_1bit a24(result[24],carryin[25],aluSrc1[24],aluSrc2[24],invertA,invertB,operation,carryin[24],0);
	ALU_1bit a25(result[25],carryin[26],aluSrc1[25],aluSrc2[25],invertA,invertB,operation,carryin[25],0);
	ALU_1bit a26(result[26],carryin[27],aluSrc1[26],aluSrc2[26],invertA,invertB,operation,carryin[26],0);
	ALU_1bit a27(result[27],carryin[28],aluSrc1[27],aluSrc2[27],invertA,invertB,operation,carryin[27],0);
	ALU_1bit a28(result[28],carryin[29],aluSrc1[28],aluSrc2[28],invertA,invertB,operation,carryin[28],0);
	ALU_1bit a29(result[29],carryin[30],aluSrc1[29],aluSrc2[29],invertA,invertB,operation,carryin[29],0);
	ALU_1bit a30(result[30],carryin[31],aluSrc1[30],aluSrc2[30],invertA,invertB,operation,carryin[30],0);
	ALU_1bit a31(result[31],carryout,aluSrc1[31],aluSrc2[31],invertA,invertB,operation,carryin[31],0);	
	
	assign high=carryin[31]^aluSrc1[31]^(~aluSrc2[31]);
	assign overflow=(carryout==1&&carryin[31]==0)||(carryout==0&&carryin[31]==1)?1:0;
	assign set=(~aluSrc2[31]&&aluSrc1[31])||((~(aluSrc1[31]^aluSrc2[31]))&&high);
	assign zero=(result==0)?1:0;

endmodule
