`include "transaction.sv"
class driver;
  transaction tr;
  mailbox mbx;
  virtual intf vif;

  function new(mailbox mbx, virtual intf vif);
    this.mbx = mbx;
    this.vif = vif;
  endfunction

  task run();
    forever begin
      tr=new();
      mbx.get(tr);
      vif.in  = tr.in;
      vif.sel = tr.sel;
      #1;
      $display("Driver drove: in=%0b sel=%0b", vif.in, vif.sel);
      end
  endtask
endclass
