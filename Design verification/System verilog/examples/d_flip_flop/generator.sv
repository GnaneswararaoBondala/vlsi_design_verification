`include "transaction.sv"
class dff_gen;
  transaction tr;
  mailbox gen2drv;
  virtual dff_intf vif;
  function new(mailbox gen2drv);
    this.gen2drv=gen2drv;
  endfunction
  task run();
    repeat(7)
      begin
        tr=new();
        tr.randomize();
        tr.display("generator class signals");
        gen2drv.put(tr);
      end
  endtask
endclass
  
