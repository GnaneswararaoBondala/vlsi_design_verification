`include "transaction.sv"
`include "interface.sv"
class driver;
  mailbox mbx;
  
  virtual intf vif;
  function new(mailbox mbx,virtual intf vif);
    this.mbx=mbx;
    this.vif=vif;
  endfunction
  task run();
    forever begin
      transaction tr;
      mbx.get(tr);
      vif.in=tr.in;
      #1;
      $display("[DRV] sent=%0b",vif.in);
    end
  endtask
endclass
    
  