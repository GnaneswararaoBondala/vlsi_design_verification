`ifndef TRANSACTION_SV
`define TRANSACTION_SV
class transaction;
  rand bit [2:0]in;
  bit [7:0]out;
  
  //constraint c1{in.size==3;}
endclass
`endif