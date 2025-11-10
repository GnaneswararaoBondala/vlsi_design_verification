`include "environment.sv"
`timescale 1ns/1ps
environment env;

module tb;

  
  bit wr_clk = 0;
  bit rd_clk = 0;
  bit wr_rst = 0;
  bit rd_rst = 0;

  
  always #5 wr_clk = ~wr_clk;   
  always #7 rd_clk = ~rd_clk;   

  
  fifo_if #(8) vif (.wr_clk(wr_clk), .rd_clk(rd_clk));

  
  async_fifo #(8) dut (
    .wr_clk(wr_clk),
    .rd_clk(rd_clk),
    .wr_rst(vif.wr_rst),
    .rd_rst(vif.rd_rst),
    .wr_en(vif.wr_en),
    .rd_en(vif.rd_en),
    .data_in(vif.data_in),
    .data_out(vif.data_out),
    .full(vif.full),
    .empty(vif.empty)
  );

 
  environment env;

  initial begin
    
    vif.wr_rst = 1;
    vif.rd_rst = 1;
    #20;
    vif.wr_rst = 0;
    vif.rd_rst = 0;

    
    env = new(vif);
    env.run();

   
    #2000;
    $display("TEST COMPLETED");    
    $finish;
  end

endmodule
