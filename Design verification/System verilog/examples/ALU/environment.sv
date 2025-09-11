`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
`include "interface.sv"
class environment;
  generator gen;
  driver drv;
  monitor mon;
  scoreboard scb;
  
  mailbox mbx;
  mailbox mon2scb;
  virtual intf vif;
  
  function new(virtual intf vif);
    this.vif=vif;//follow this order only for defining
    mbx=new();
    mon2scb=new();
    gen=new(mbx);
    drv=new(mbx,vif);
    mon=new(vif,mon2scb);
    scb=new(mon2scb);
  endfunction
  
  task run();
    fork
      gen.run();
      drv.run();
      mon.run();
      scb.run();
    join_none
  endtask
endclass
    
    