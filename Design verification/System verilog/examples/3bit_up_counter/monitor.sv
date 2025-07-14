`include "transaction.sv"
`ifndef MONITOR_SV
`define MONITOR_SV
class count_mon;
  virtual count_intf vif;
  mailbox mon2scb;

  function new(mailbox mon2scb, virtual count_intf vif);
    this.mon2scb = mon2scb;
    this.vif = vif;
  endfunction

  task run();
    forever begin
      @(posedge vif.clk);
      mon2scb.put(vif.count);
    end
  endtask
endclass
`endif
