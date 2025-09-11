`include "transaction.sv"
class monitor;
  transaction tr;
  mailbox mon2scb;
  virtual intf vif;

  function new(virtual intf vif, mailbox mon2scb);
    this.vif     = vif;
    this.mon2scb = mon2scb;
  endfunction

  task run();
    forever begin
      tr = new();
      @(vif.in or vif.sel or vif.out); // wake on any change
      #1; // settle
      tr.in  = vif.in;
      tr.sel = vif.sel;
      tr.out = vif.out;
      mon2scb.put(tr);
      $display("Monitor captured: in=%0b sel=%0b out=%0b",
               tr.in, tr.sel, tr.out);
    end
  endtask
endclass
