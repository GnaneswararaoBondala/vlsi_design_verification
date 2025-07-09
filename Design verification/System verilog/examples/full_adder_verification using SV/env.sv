`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"

class environment;
  generator gen;
  driver drv;
  monitor mon;
  scoreboard scb;
  mailbox mbx1;
  mailbox mbx2;
  virtual fa_intf vif;
  function new(virtual fa_intf vif);
    this.vif=vif;
    mbx1=new();
    mbx2=new();
    gen=new(mbx1);
    drv=new(vif,mbx1);
    mon=new(vif,mbx2);
    scb=new(mbx2);
  endfunction
  
  task run();
    fork
      gen.run();
      drv.run();
      mon.run();
      scb.run();
    join
  endtask
endclass
      
    