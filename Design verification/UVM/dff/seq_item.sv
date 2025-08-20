`ifndef SEQ_ITEM_SV
`define SEQ_ITEM_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

//---------------- Sequence Item ----------------
class dff_seq_item extends uvm_sequence_item;
  `uvm_object_utils(dff_seq_item)

  rand bit rst;   // input to DUT
  rand bit d;     // input to DUT
       bit q;     // output from DUT (sampled by monitor)

  function new(string name="dff_seq_item");
    super.new(name);
  endfunction

  function string convert2string();
    return $sformatf("rst=%0b d=%0b q=%0b", rst, d, q);
  endfunction
endclass

`endif

