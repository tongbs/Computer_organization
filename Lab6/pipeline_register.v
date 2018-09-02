module pipeline_register(clk,rst,data_i,data_o,pwrite);

parameter size = 0;

input clk;
input rst;
input pwrite;
input wire	[size-1:0] data_i;
output [size-1:0] data_o;
reg [size-1:0] data_o;

always @(posedge clk,negedge rst) begin
	if(~rst)
	    data_o<=0;
	else if(pwrite)
		data_o<=data_o;
	else
	    data_o<=data_i;
end

endmodule