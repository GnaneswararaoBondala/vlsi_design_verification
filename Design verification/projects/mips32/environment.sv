`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"

class env;
  mips_gen gen;
  mips_drv drv;
  mips_mon mon;
  mips_scb scb;
  virtual mips_if vif;

  function new(virtual mips_if vif);
    this.vif = vif;
    gen = new();
    drv = new(vif);
    mon = new(vif);
  endfunction

  task run();
    gen.create_txn();
    drv.apply_txn(gen.txn);

    fork
      mon.sample();
    join

    scb = new(gen.txn);
    scb.observed_reg = mon.observed_reg;
    scb.compare();
  endtask
endclass
