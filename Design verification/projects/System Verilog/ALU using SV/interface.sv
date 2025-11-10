`ifndef INTERFACE_SV
`define INTERFACE_SV
interface intf;  //Interface we will use both virtual and physical.
  logic [2:0]a;
  logic [2:0]b;
  logic [2:0]sel;
  logic [4:0]out;
endinterface
`endif