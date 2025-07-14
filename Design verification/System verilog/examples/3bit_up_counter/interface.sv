`ifndef INTERFACE_SV
`define INTERFACE_SV
interface count_intf(input logic clk);
  logic rst;
  logic [2:0] count;

  clocking cb @(posedge clk);
    input count;
    output rst;
  endclocking
endinterface
`endif

