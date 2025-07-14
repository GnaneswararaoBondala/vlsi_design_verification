`include "generator.sv"
`include "driver.sv"
`include "monitor.sv";
`include "scoreboard.sv"
`ifndef ENVIRONMENT_SV
`define ENVIRONMENT_SV

class count_env;

  // Component instances
  count_gen gen;
  count_drv drv;
  count_mon mon;
  count_scb scb;

  // Communication channels
  mailbox gen2drv;
  mailbox mon2scb;

  // Virtual interface
  virtual count_intf vif;

  // Constructor
  function new(virtual count_intf vif);
    this.vif = vif;

    // Create mailboxes
    gen2drv = new();
    mon2scb = new();

    // Instantiate components
    gen = new(gen2drv);
    drv = new(gen2drv, vif);
    mon = new(mon2scb, vif);
    scb = new(mon2scb);
  endfunction

  // Run all components in parallel
  task run();
    fork
      gen.run();
      drv.run();
      mon.run();
      scb.run();
    join
  endtask

endclass
`endif


