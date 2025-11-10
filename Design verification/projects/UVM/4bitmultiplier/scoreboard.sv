`include "uvm_macros.svh"
import uvm_pkg::*;
`include "transaction.sv"
`ifndef SCOREBOARD_SV
`define SCOREBOARD_SV

class sco extends uvm_scoreboard;
`uvm_component_utils(sco);

uvm_analysis_imp#(transaction,sco)recv;

function new(string name="sco",uvm_component parent);
super.new(name,parent);
endfunction

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
recv=new("recv",this);
endfunction

virtual function void write(transaction tr);
if(tr.y==(tr.a * tr.b))
`uvm_info("sco",$sformatf("Test passed, ->a:%0d b:%0d y:%0d",tr.a,tr.b,tr.y),UVM_NONE)
else
`uvm_info("sco",$sformatf("test failed,->a:%0d b:%0d y:%0d",tr.a,tr.b,tr.y),UVM_NONE)
$display("-------");
endfunction 
endclass
`endif



