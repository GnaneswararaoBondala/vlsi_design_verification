`include "transaction.sv"
`ifndef DRIVER_SV
`define DRIVER_SV
class count_drv;
  virtual count_intf vif;
  mailbox gen2drv;

  function new(mailbox gen2drv, virtual count_intf vif);
    this.gen2drv = gen2drv;
    this.vif = vif;
  endfunction

  task run();
    count_txn txn;
    forever begin
      gen2drv.get(txn);
      @(posedge vif.clk);
      vif.rst <= txn.reset;
    end
  endtask
endclass
`endif
`
