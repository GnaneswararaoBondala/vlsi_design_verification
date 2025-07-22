`include "transaction.sv"
`ifndef GENERATOR_SV
`define GENERATOR_SV
class mips_gen;
  mips_txn txn;

  function new();
  endfunction

  task create_txn();
    // Generate simple program and register init
    for (int i = 0; i < 32; i++) begin
      txn.instr_mem[i] = 32'h00000000; // NOP or default instruction
      txn.init_reg[i] = i;             // Register i = i
    end
  endtask
endclass
`endif
