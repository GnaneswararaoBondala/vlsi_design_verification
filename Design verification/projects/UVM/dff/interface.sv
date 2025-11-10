`ifndef INTERFACE_SV
`define INTERFACE_SV

//---------------- Interface ----------------
interface dff_intf(input logic clk);
  logic rst;
  logic d;
  logic q;
endinterface

`endif
