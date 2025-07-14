`include "transaction.sv"
`ifndef GENERATOR_SV
`define GENERATOR_SV
class count_gen;
  mailbox gen2drv;

  function new(mailbox gen2drv);
    this.gen2drv = gen2drv;
  endfunction

  task run();
    count_txn txn;
    repeat (20) begin
      txn = new();
      txn.reset = ($urandom_range(0, 1));
      txn.display("GEN");
      gen2drv.put(txn);
      #10;
    end
  endtask
endclass
`endif


