module tb;

  parameter FIFO_DEPTH = 16;
  parameter FIFO_WIDTH = 8;

  reg clk=0,rst_n;
  reg wr_en, rd_en;
  reg [FIFO_WIDTH-1:0] data_in;

  wire [FIFO_WIDTH-1:0] data_out;
  wire wr_ack, overflow, full, empty, almostfull, almostempty, underflow;

  // FIFO DUT
  FIFO dut (.clk(clk),.rst_n(rst_n),.data_in(data_in),.wr_en (wr_en),.rd_en(rd_en),.wr_ack(wr_ack),.overflow(overflow),.full(full),.empty(empty),
            .almostfull (almostfull),.almostempty(almostempty),.underflow  (underflow),
            .data_out   (data_out)
  );

  //ASSERTIONS DUT
  bind FIFO assert_fifo dut2(
    .clk(clk),
    .rst_n(rst_n),
    .wr_en(wr_en),
    .rd_en(rd_en),
    .count(dut.count),
    .rd_ptr(dut.rd_ptr),
    .wr_ptr(dut.wr_ptr),
    .wr_ack(wr_ack),
    .full(full),
    .empty(empty),
    .almostfull(almostfull),
    .almostempty(almostempty),
    .overflow(overflow),
    .underflow(underflow)
  );

  
  initial clk = 0;
  always #5 clk = ~clk;

  initial begin
    $monitor("t=%0t | rst=%0b wr=%0b rd=%0b data_in=%0d data_out=%0d full=%0b empty=%0b",
              $time, rst_n, wr_en, rd_en, data_in, data_out, full, empty);
  end

  initial begin
    rst_n = 0;
    wr_en = 0;
    rd_en = 0;
    data_in = 0;

    #20 rst_n = 1;
    #20 rst_n = 0;
    #20 rst_n = 1;

   
    repeat (10) begin
      @(posedge clk);
      wr_en = 1;
      data_in = $urandom_range(0,255);
    end
    @(posedge clk);
    wr_en = 0;

    
    repeat (10) begin
      @(posedge clk);
      rd_en = 1;
    end
    @(posedge clk);
    rd_en = 0;

    #50;
    $finish;
  end

endmodule

module assert_fifo(
  input clk,
  input rst_n,
  input wr_en,
  input rd_en,
  input [4:0] count,
  input [3:0] rd_ptr,
  input [3:0] wr_ptr,
  input wr_ack,
  input full,
  input empty,
  input almostfull,
  input almostempty,
  input overflow,
  input underflow
);

  property p1;
    @(posedge clk)
      $rose(rst_n) |-> (wr_en == 0);
  endproperty

  assert property(p1)
    $display("p1 PASS: write disabled during reset release @%0t", $time);
  else
    $error("p1 FAIL: write enabled during reset release @%0t", $time);

  property p2;
    @(posedge clk)
      $rose(rst_n) |-> (rd_en == 0);
  endproperty

  assert property(p2)
    $display("p2 PASS: read disabled during reset release @%0t", $time);
  else
    $error("p2 FAIL: read enabled during reset release @%0t", $time);


  property p3;
    @(posedge clk) disable iff(!rst_n)
      (wr_en && !full) |-> ##1 wr_ack;
  endproperty

  assert property(p3)
    $display("p3 PASS: wr_ack received after valid write @%0t", $time);
  else
    $error("p3 FAIL: wr_ack missing after write @%0t", $time);


  property p4;
    @(posedge clk) disable iff(!rst_n)
      (wr_en && !full) |-> (wr_ptr == $past(wr_ptr)+1);
  endproperty

  assert property(p4)
    $display("p4 PASS: write pointer incremented @%0t", $time);
  else
    $error("p4 FAIL: write pointer NOT incremented @%0t", $time);


  property p5;
    @(posedge clk) disable iff(!rst_n)
      (rd_en && !empty) |-> ##1 !empty;
  endproperty

  assert property(p5)
    $display("p5 PASS: read OK, FIFO not unexpectedly empty @%0t", $time);
  else
    $error("p5 FAIL: read error, FIFO empty unexpectedly @%0t", $time);


  property p6;
    @(posedge clk) disable iff(!rst_n)
      (rd_en && !empty) |-> (rd_ptr == $past(rd_ptr)+1);
  endproperty

  assert property(p6)
    $display("p6 PASS: read pointer incremented @%0t", $time);
  else
    $error("p6 FAIL: read pointer NOT incremented @%0t", $time);


  property p7;
    @(posedge clk)
      $fell(rst_n) |-> ##1 (count == 0);
  endproperty

  assert property(p7)
    $display("p7 PASS: count reset to zero @%0t", $time);
  else
    $error("p7 FAIL: count NOT zero after reset @%0t", $time);

  property p8;
    @(posedge clk) disable iff(!rst_n)
      (wr_en && !full) |-> (count == $past(count)+1);
  endproperty

  assert property(p8)
    $display("p8 PASS: count incremented on write @%0t", $time);
  else
    $error("p8 FAIL: count did NOT increment on write @%0t", $time);

  property p9;
    @(posedge clk) disable iff(!rst_n)
      (rd_en && !empty) |-> (count == $past(count)-1);
  endproperty

  assert property(p9)
    $display("p9 PASS: count decremented on read @%0t", $time);
  else
    $error("p9 FAIL: count did NOT decrement on read @%0t", $time);

endmodule
