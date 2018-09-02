module check_branch(branch,zero,pc_src);

input branch;
input zero;

output pc_src;

wire pc_src;

assign pc_src = branch & zero;

endmodule