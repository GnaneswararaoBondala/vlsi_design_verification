`include "transaction.sv"
`include "interface.sv"
class monitor;
  transaction tr;
  mailbox mon2scb;
  virtual intf vif;
  function new(virtual intf vif,mailbox mon2scb);
    this.vif=vif;
    this.mon2scb=mon2scb;
  endfunction
  task run();
    forever begin
      tr=new();
      @(vif.in or vif.out)
      tr.in=vif.in;
      tr.out=vif.out;
      mon2scb.put(tr);
      $display("[MON] Monitor signals in=%0b and out=%0b",tr.in,tr.out);
    end
  endtask
endclass
    