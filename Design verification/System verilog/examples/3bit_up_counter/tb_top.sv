`include "design.sv"
`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv";
`include "scoreboard.sv"
`include "interface.sv"
`include "environment.sv"
`include "test.sv"


module tb_top;

  logic clk;
  always #5 clk = ~clk;
  initial clk = 0;

  // Reset Logic
  initial begin
    #500 $finish;
  end

  // Interface and DUT instantiation
  count_intf intf(clk);

  count dut (
    .clk(clk),
    .rst(intf.rst),
    .count(intf.count)
  );

  // Run test
  initial begin
    count_test test;
    test = new(intf);
    test.run();
  end

endmodule

