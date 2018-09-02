module CalculateJump(pc_bits , instr_bits , jump_address);

input    [3:0]pc_bits;
input    [25:0]instr_bits;

output   [31:0]jump_address;

wire     [31:0]jump_address;

assign jump_address = {pc_bits , instr_bits , 2'b00};

endmodule