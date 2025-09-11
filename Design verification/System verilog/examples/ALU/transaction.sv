`ifndef TRANSACTION_SV   //if many classes using these class,collision will                               happen and error you will get like multiply                                     defined,For to avoid that you can use these two                             lines
`define TRANSACTION_SV
class transaction;
  rand bit [2:0]a;   //taking random values
  rand bit[2:0]b;
  rand bit[2:0]sel;
  bit [4:0]out;
endclass
`endif