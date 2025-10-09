`ifndef INTERFACE_SV
`define INTERFACE_SV
interface fifo_if #(parameter data_width = 8)
(
  input logic wr_clk,
  input logic rd_clk
);

  logic [data_width-1:0] data_in;
  logic wr_rst, rd_rst;
  logic wr_en, rd_en;

  logic [data_width-1:0] data_out;
  logic full, empty;

  modport Tb (
    input full, empty, data_out,
    output wr_rst, rd_rst, wr_en, rd_en, data_in,
    input wr_clk, rd_clk
  );

endinterface
`endif