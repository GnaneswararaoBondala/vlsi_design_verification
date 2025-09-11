`include "transaction.sv"
`include "interface.sv"
class driver;
  transaction tr;
  mailbox mbx;
  virtual intf vif;  //using virtual interface(All classes are dynamic).

  function new(mailbox mbx,virtual intf vif);
    this.mbx=mbx;
    this.vif=vif;
  endfunction
    
  task run();
    forever begin
      mbx.get(tr); //Getting from mailbox
      vif.a=tr.a;  //transferring from transaction to virtual interface
      vif.b=tr.b;
      vif.sel=tr.sel;
      #1;
      $display("Driver signals sent vif.a=%0d,vif.b=%0d,vif.sel=%0d",vif.a,vif.b,vif.sel);
    end
  endtask
endclass
      