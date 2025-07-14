`ifndef TRANSACTION_SV
`define TRANSACTION_SV
class count_txn;
  rand bit reset;

  function void display(string tag="");
    $display("[%s] Reset = %0b", tag, reset);
  endfunction
endclass
`endif

