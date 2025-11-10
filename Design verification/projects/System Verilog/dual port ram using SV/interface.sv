`ifndef INTERFACE_SV
`define INTERFACE_SV
interface intf(input logic clk, input logic rstn);
    logic [4:0] w_addr;
    logic [4:0] r_addr;
    logic       wr;
    logic       rd;
    logic       enb;
    logic [7:0] w_data;
    logic [7:0] r_data;
endinterface
`endif