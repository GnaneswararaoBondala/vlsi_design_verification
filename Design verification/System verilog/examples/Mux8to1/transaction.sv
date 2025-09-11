`ifndef TRANSACTION_SV
`define TRANSACTION_SV
class transaction;
  rand bit [7:0] in;
  rand bit [2:0] sel;
  bit out;

  function void display(string tag);
    $display("[%0s] in=%0b sel=%0b out=%0b", tag, in, sel, out);
  endfunction
endclass
`endif
