module ShiftLeft(Bshifted,Ashifted);

input  [31:0] Bshifted;
output [31:0] Ashifted;
wire   [31:0] Ashifted;

assign Ashifted = Bshifted << 2;

endmodule