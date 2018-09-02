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
  wire b_invert;   wire add;  wire addCarryout;
				   wire sub;  wire subCarryout;
  assign b_invert=~b;				  
  Full_adder add_add (add, addCarryout, carryIn, a, b); Full_adder add_sub (sub, subCarryout, carryIn, a, b_invert);

  assign carryOut=(operation[1]==1)?((invertB==0)?addCarryout:subCarryout):0;
  
  
  assign result=(invertA==1)?((operation[0]==1)?~(a&b):~(a|b)):
									((invertB==1)?((operation[0]==1)?less:sub):
				((operation[1]==1)?add :((operation[0]==1)?a|b:a&b)));//or and
endmodule




