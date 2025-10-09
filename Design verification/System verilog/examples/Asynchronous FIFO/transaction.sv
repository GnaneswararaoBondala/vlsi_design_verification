`ifndef TRANSACTION_SV
`define TRANSACTION_SV
class transaction;

  rand bit [7:0] data;
  rand bit wr_en;
  rand bit rd_en;

  bit [7:0] expected_data;

  function new();
    data = 8'h00;
    wr_en = 0;
    rd_en = 0;
    expected_data = 8'h00;
  endfunction

  function void display(string tag = " ");
    $display("[%0s] TX: wr_en=%0b, rd_en=%0b, data=0x%0h, expected=0x%0h",
             tag, wr_en, rd_en, data, expected_data);
  endfunction

  function transaction copy();
    transaction t = new();
    t.data = this.data;
    t.wr_en = this.wr_en;
    t.rd_en = this.rd_en;
    t.expected_data = this.expected_data;
    return t;
  endfunction

  function bit compare(transaction t);
    return (this.data == t.data);
  endfunction

endclass
`endif

