module shifter_control(funct_i,shifter_exe);

input [5:0] funct_i;
output shifter_exe;

wire shifter_exe;

assign shifter_exe = (funct_i == 6'b000100)?0:(funct_i == 6'b000110)?0:1;

endmodule