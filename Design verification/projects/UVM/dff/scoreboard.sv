`ifndef SCOREBOARD_SV
`define SCOREBOARD_SV
`include "seq_item.sv"

`include "uvm_macros.svh"
import uvm_pkg::*;

//---------------- Scoreboard ----------------
class dff_scoreboard extends uvm_component;
  `uvm_component_utils(dff_scoreboard)

  uvm_analysis_imp #(dff_seq_item, dff_scoreboard) item_collected_export;
  bit expected_q;

  function new(string name="dff_scoreboard",uvm_component parent);
    super.new(name,parent);
    item_collected_export = new("item_collected_export",this);
  endfunction

  function void write(dff_seq_item tx);
    // Reference model: q = 0 on reset, else q = d
    if (tx.rst)
      expected_q = 0;
    else
      expected_q = tx.d;

    if (tx.q !== expected_q)
      `uvm_error("SCB",$sformatf("Mismatch: rst=%0b d=%0b q=%0b exp_q=%0b",
                                  tx.rst, tx.d, tx.q, expected_q))
    else
      `uvm_info("SCB",$sformatf("Match: %s", tx.convert2string()), UVM_LOW)
  endfunction
endclass

`endif

