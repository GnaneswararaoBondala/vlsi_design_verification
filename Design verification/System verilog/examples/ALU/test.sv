`include "interface.sv"
`include "environment.sv"
class test;
  virtual intf vif;
  environment env;
  
  function new(virtual intf vif);
    this.vif=vif;
    env=new(vif);
  endfunction
  
  task run();
    env.run();
  endtask
endclass
    
    