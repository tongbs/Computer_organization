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
  wire a1,b1;
  wire and1,or1;
  wire F; //full_adder
  assign a1 = (invertA == 1'b1)?~a:a;
  assign b1 = (invertB == 1'b1)?~b:b;
  
  assign and1 = a1&b1;
  assign or1 = a1|b1;
  
  Full_adder full(.sum(F), .carryOut(carryOut), .carryIn(carryIn), .input1(a1), .input2(b1));
  
  assign result = (operation == 2'b00)?and1:
				  (operation == 2'b01)?or1:
				  (operation == 2'b10)?F:
				  less;
  
endmodule