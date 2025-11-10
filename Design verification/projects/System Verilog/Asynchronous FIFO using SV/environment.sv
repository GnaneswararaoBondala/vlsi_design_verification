`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
class environment;

  
  generator gen;
  driver drv;
  monitor mon;
  scoreboard scb;

  mailbox gen2drv;
  mailbox mon2scb;

  
  virtual fifo_if.Tb vif;

  function new(virtual fifo_if.Tb vif);
    this.vif = vif;
    gen2drv = new();
    mon2scb = new();

   
    gen = new(gen2drv);
    drv = new(vif, gen2drv);
    mon = new(vif, mon2scb);
    scb = new(mon2scb);
  endfunction

  task run();    
    $display("STARTING FIFO ENVIRONMENT");
    fork
      gen.run();
      drv.run();
      mon.run();
      scb.run();
    join_none
  endtask

endclass
