`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"

class dff_env;
  dff_gen gen_h;
  dff_drv drv_h;
  dff_mon mon_h;
  dff_scb scb_h;
  
  mailbox gen2drv;
  mailbox mon2scb;
  
  virtual dff_intf vif;
  function new(virtual dff_intf vif);
    this.vif=vif;
    gen2drv=new();
    mon2scb=new();
    
    gen_h=new(gen2drv);
    drv_h=new(gen2drv,vif);
    mon_h=new(mon2scb,vif);
    scb_h=new(mon2scb);
  endfunction
  
  task run();
    fork
      gen_h.run();
      drv_h.run();
      mon_h.run();
      scb_h.run();
    join
  endtask
endclass