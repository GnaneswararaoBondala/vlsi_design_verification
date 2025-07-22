interface mips_if(input bit clk1, input bit clk2);
  logic HALTED;
  logic TAKEN_BRANCH;
  logic [31:0] PC;
  logic [31:0] Reg[0:31];
  logic [31:0] Mem[0:1023];
endinterface
