`include "transaction.sv"
`ifndef SCOREBOARD_SV
`define SCOREBOARD_SV
class count_scb;
  mailbox mon2scb;
  int expected = 0;

  function new(mailbox mon2scb);
    this.mon2scb = mon2scb;
  endfunction

  task run();
    logic [2:0] actual;
    forever begin
      mon2scb.get(actual);
      if (actual !== expected[2:0])
        $error("ERROR: Expected %0d, Got %0d", expected, actual);
      else
        $display("PASS: %0d == %0d", expected, actual);

      expected = (expected + 1) % 8;
    end
  endtask
endclass
`endif

