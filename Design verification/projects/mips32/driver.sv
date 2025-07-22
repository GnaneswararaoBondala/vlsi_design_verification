`include "transaction.sv"
`ifndef DRIVER_SV
`define DRIVER_SV
class mips_drv;
  virtual mips_if vif;
  mips_txn txn;

  function new(virtual mips_if vif);
    this.vif = vif;
  endfunction

  task apply_txn(mips_txn t);
    txn = t;
    for (int i = 0; i < 32; i++)
      vif.Mem[i] = txn.instr_mem[i];
    for (int i = 0; i < 32; i++)
      vif.Reg[i] = txn.init_reg[i];

    vif.PC = 0;
    vif.HALTED = 0;
    vif.TAKEN_BRANCH = 0;
  endtask
endclass
`endif
