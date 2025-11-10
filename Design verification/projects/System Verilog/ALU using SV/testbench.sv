`include "interface.sv"
`include "test.sv"
module tb;
  intf aif(); //using physical interface
  
  alu u1(.a(aif.a),.b(aif.b),.sel(aif.sel),.out(aif.out));
  
  virtual intf vif;
  test t;
  
  
  initial begin
    vif=aif;
    t=new(vif);
    t.run();
    #200;
    $finish;
  end
endmodule
    