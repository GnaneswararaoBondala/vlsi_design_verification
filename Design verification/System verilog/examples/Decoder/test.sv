`include "interface.sv"
`include "environment.sv"
class test;
  environment env;
  virtual intf vif;
  
  function new(virtual intf vif);
    this.vif=vif;
    env=new(vif);
  endfunction
  
  task run();
    env.run();
  endtask
endclass