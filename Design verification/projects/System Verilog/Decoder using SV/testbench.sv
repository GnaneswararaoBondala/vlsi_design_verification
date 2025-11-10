`include "generator.sv"
`include "driver.sv"
`include "interface.sv"
`include "monitor.sv"
`include "scoreboard.sv"
`include "test.sv"
`include "environment.sv"
module tb;
  intf aif();
  decoder u1(.in(aif.in),.out(aif.out));
  
  virtual intf vif;
  test t;
  
  initial begin
    vif=aif;
    t=new(vif);
    t.run();
  end
endmodule