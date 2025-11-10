`timescale 1ns/1ns

`include "interface.sv"
`include "uvm_macros.svh"
import uvm_pkg::*;

`include "seq_item.sv"
`include "sequence.sv"
`include "sequencer.sv"
`include "driver.sv"
`include "monitor.sv"
`include "agent.sv"
`include "scoreboard.sv"
`include "environment.sv"
`include "test.sv"

//---------------- Top TB ----------------
module top;
  logic clk;
  dff_intf intf(clk);

  // DUT instance
  dff dut(.clk(clk), .rst(intf.rst), .d(intf.d), .q(intf.q));

  // Clock generation
  initial clk = 0;
  always #5 clk = ~clk;

  // Config + run UVM
  initial begin
    uvm_config_db#(virtual dff_intf)::set(null,"*","vif",intf);
    run_test("dff_test");
  end
endmodule

