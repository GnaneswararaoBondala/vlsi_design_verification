`include "environment.sv"
program dff_test(dff_intf vif);
  dff_env env_h;
  initial begin
    env_h=new(vif);
    env_h.run();
  end
endprogram
