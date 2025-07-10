`include "interface.sv"
`include "test.sv"

module tb_top();
  logic clk;

  // Instantiate interface
  dff_intf vif(clk);
  dff_test test_h(vif);

  // DUT instantiation
  dff dut(.clk(clk), .rst(vif.rst), .d(vif.d), .q(vif.q), .qbar(vif.qbar));

  // Clock generation
  initial clk = 0;
  always #5 clk = ~clk;

  // Test instance and run
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,tb_top);
    #200;
    $finish;
  end
endmodule
