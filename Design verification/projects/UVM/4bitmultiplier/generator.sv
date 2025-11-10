`include "uvm_macros.svh"
import uvm_pkg::*;
`include "transaction.sv"
`ifndef GENERATOR_SV
`define GENERATOR_SV 


class generator extends uvm_sequence#(transaction);
`uvm_object_utils(generator);
transaction tr;
function new(input string path="generator");
super.new(path);
endfunction

virtual task body();
repeat(10)
begin
tr=transaction::type_id::create("tr");
start_item(tr);
assert(tr.randomize());
`uvm_info("SEQ",$sformatf("a:%0d b:%0d y:%0d ",tr.a,tr.b,tr.y),UVM_NONE);
finish_item(tr);
end
endtask
endclass
`endif

