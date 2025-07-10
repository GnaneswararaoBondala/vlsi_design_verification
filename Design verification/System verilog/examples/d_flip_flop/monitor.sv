class dff_mon;
  virtual dff_intf vif;
  mailbox mon2scb;
  transaction trans;
  function new(mailbox mon2scb,virtual dff_intf vif);
    this.vif=vif;
    this.mon2scb=mon2scb;
  endfunction
  task run;
    repeat(7)
      begin
        @(posedge vif.clk)
        trans=new();
        trans.rst=vif.rst;
        trans.d=vif.d;
        trans.q=vif.q;
        trans.qbar=vif.qbar;
        mon2scb.put(trans);
        trans.display("monitor class signals");
      end
  endtask
endclass