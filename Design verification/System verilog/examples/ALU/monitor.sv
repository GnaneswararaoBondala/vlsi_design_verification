`include "transaction.sv"
`include "interface.sv"
class monitor;
  transaction tr;
  mailbox mon2scb;//mailbox 2
  virtual intf vif;
  function new(virtual intf vif,mailbox mon2scb);
    this.vif=vif;
    this.mon2scb=mon2scb;
  endfunction
  task run();
    forever begin
      tr=new();
      @(vif.a or vif.b)
      tr.a=vif.a; //now from virtual interface to transaction with output calculated in dut
      tr.b=vif.b;
      tr.sel=vif.sel;
      tr.out=vif.out;
      mon2scb.put(tr); //Putting in mailbox 2
      $display("Monitor signals sent tr.a=%0d,tr.b=%0d,tr.sel=%0d and tr.out=%0d",tr.a,tr.b,tr.sel,tr.out);
    end
  endtask
endclass