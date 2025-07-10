class dff_drv;
  virtual dff_intf vif;
  mailbox gen2drv;
  transaction tr;
  function new(mailbox gen2drv,virtual dff_intf vif);
    this.gen2drv=gen2drv;
    this.vif=vif;
  endfunction
  task run();
    forever begin
      gen2drv.get(tr);
      vif.rst<=tr.rst;
      vif.d<=tr.d;
      @(posedge vif.clk);
      tr.display("______driver class signals______");
    end
  endtask
endclass
      