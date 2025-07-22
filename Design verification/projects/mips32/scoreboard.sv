`include "transaction.sv"
`ifndef SCOREBOARD_SV
`define SCOREBOARD_SV
class mips_scb;
  mips_txn txn;
  bit [31:0] observed_reg[0:31];

  function new(mips_txn txn);
    this.txn = txn;
  endfunction

  task compare();
    for (int i = 0; i < 32; i++) begin
      if (txn.init_reg[i] !== observed_reg[i])
        $display("[SCB] Mismatch at Reg[%0d]: Expected=%0d, Observed=%0d", i, txn.init_reg[i], observed_reg[i]);
    end
    $display("[SCB] Comparison done.");
  endtask
endclass
`endif