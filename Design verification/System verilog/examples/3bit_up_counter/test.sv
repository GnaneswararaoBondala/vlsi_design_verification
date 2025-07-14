`include "environment.sv"
`include "interface.sv"
`ifndef TEST_SV
`define TEST_SV
class count_test;
  count_env env;

  function new(virtual count_intf vif);
    env = new(vif);
  endfunction

  task run();
    env.run();
  endtask
endclass
`endif

