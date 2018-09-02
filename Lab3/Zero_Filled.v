module Zero_Filled( data_i, data_o );

//I/O ports
input	[16-1:0] data_i;
output	[32-1:0] data_o;

//Internal Signals
wire	[32-1:0] data_o;

//Zero_Filled
/*your code here*/

assign data_o[31] = data_i[15];
assign data_o[31] = data_i[14];
assign data_o[31] = data_i[13];
assign data_o[31] = data_i[12];
assign data_o[31] = data_i[11];
assign data_o[31] = data_i[10];
assign data_o[31] = data_i[9];
assign data_o[31] = data_i[8];
assign data_o[31] = data_i[7];
assign data_o[31] = data_i[6];
assign data_o[31] = data_i[5];
assign data_o[31] = data_i[4];
assign data_o[31] = data_i[3];
assign data_o[31] = data_i[2];
assign data_o[31] = data_i[1];
assign data_o[31] = data_i[0];

//zero_field
assign data_o[15] = 1'b0;
assign data_o[14] = 1'b0;
assign data_o[13] = 1'b0;
assign data_o[12] = 1'b0;
assign data_o[11] = 1'b0;
assign data_o[10] = 1'b0;
assign data_o[9] = 1'b0;
assign data_o[8] = 1'b0;
assign data_o[7] = 1'b0;
assign data_o[6] = 1'b0;
assign data_o[5] = 1'b0;
assign data_o[4] = 1'b0;
assign data_o[3] = 1'b0;
assign data_o[2] = 1'b0;
assign data_o[1] = 1'b0;
assign data_o[0] = 1'b0;

endmodule      
