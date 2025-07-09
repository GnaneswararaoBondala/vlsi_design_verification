class monitor;
  virtual fa_intf vif;
  mailbox mon2scb;
  transaction trans;
  function new(virtual fa_intf vif,mailbox mon2scb);
    this.vif=vif;
    this.mon2scb=mon2scb;
  endfunction
  task run();
    repeat(5)
      begin
        #1;
        trans=new();
        trans.a=vif.a;
        trans.b=vif.b;
        trans.cin=vif.cin;
        trans.sum=vif.sum;
        trans.cout=vif.cout;
        mon2scb.put(trans);
        trans.display("monitor class signals");
      end
  endtask
endclass
