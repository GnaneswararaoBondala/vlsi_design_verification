`include "test.sv"
`include "transaction.sv"
`include "interface.sv"

module tb;

  // Interface
  intf vif();

  // DUT
  mux8to1 dut (
    .in  (vif.in),
    .sel (vif.sel),
    .out (vif.out)
  );

  // Test object
  test t;

  initial begin
    t = new(vif);
    t.run();
    #20 $finish;
  end

  // Optional: dump waves
  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, tb);
  end

endmodule
