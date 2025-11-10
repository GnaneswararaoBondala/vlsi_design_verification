`ifndef SEQUENCER_SV
`define SEQUENCER_SV
`include "seq_item.sv"
`include "uvm_macros.svh"
import uvm_pkg::*;

//---------------- Sequencer ----------------
class dff_sequencer extends uvm_sequencer #(dff_seq_item);
  `uvm_component_utils(dff_sequencer)

  function new(string name="dff_sequencer", uvm_component parent);
    super.new(name, parent);
  endfunction
endclass

`endif

