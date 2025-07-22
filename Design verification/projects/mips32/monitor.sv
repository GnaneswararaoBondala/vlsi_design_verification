`ifndef MONITOR_SV
`define MONITOR_sV
class mips_mon;
  virtual mips_if vif;
  bit [31:0] observed_reg[0:31];
  bit halted_flag;

  function new(virtual mips_if vif);
    this.vif = vif;
  endfunction

  task sample();
    wait(vif.HALTED == 1);
    for (int i = 0; i < 32; i++)
      observed_reg[i] = vif.Reg[i];
  endtask
endclass
`endif

