class driver;
  virtual fa_intf vif;
  mailbox mbx;
  transaction tr;
  
  function new(virtual fa_intf vif,mailbox mbx);
    this.vif=vif;
    this.mbx=mbx;
  endfunction
  
  task run();
    repeat(5)
      begin
        mbx.get(tr);
        vif.a<=tr.a;
        vif.b<=tr.b;
        vif.cin<=tr.cin;
        #1;
        tr.display("_____driver class signals______");
      end
  endtask
endclass