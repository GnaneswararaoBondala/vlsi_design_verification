`ifndef SEQUENCE_SV
`define SEQUENCE_SV
`include "seq_item.sv"

`include "uvm_macros.svh"
import uvm_pkg::*;

//---------------- Sequence ----------------
class dff_sequence extends uvm_sequence #(dff_seq_item);
  `uvm_object_utils(dff_sequence)

  function new(string name="dff_sequence");
    super.new(name);
  endfunction

  task body();
    repeat (10) begin
      dff_seq_item tx;
      tx = dff_seq_item::type_id::create("tx");
      assert(tx.randomize()); // randomize rst, d
      start_item(tx);
      finish_item(tx);
    end
  endtask
endclass

`endif

