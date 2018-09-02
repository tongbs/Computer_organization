module ALU_1bit( result, carryOut, a, b, invertA, invertB, operation, carryIn, less ); 
  
  output wire result;
  output wire carryOut;
  
  input wire a;
  input wire b;
  input wire invertA;
  input wire invertB;
  input wire[1:0] operation;
  input wire carryIn;
  input wire less;
  
  /*your code here*/ 
	wire wa,wb;
	assign wa=invertA?~a:a;
	assign wb=invertB?~b:b;
	
	wire r_and,r_or,r_add;
	and a1(r_and,wa,wb);
	or  o1(r_or,wa,wb);
	Full_adder fa(r_add,carryOut,carryIn,wa,wb);

	assign result=operation==0?r_and: operation==1?r_or: operation==2?r_add:less;
	
endmodule