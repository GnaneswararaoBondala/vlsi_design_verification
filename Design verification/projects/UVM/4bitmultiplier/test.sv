`include "uvm_macros.svh"
import uvm_pkg::*;
`include "environment.sv"
`include "generator.sv"
`include "agent.sv"
`ifndef TEST_SV
`define TEST_SV


class test extends uvm_test;
`uvm_component_utils(test)
function new(input string inst="test",uvm_component parent);
super.new(inst,parent);
endfunction
environment e;
generator gen;
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
e=environment::type_id::create("env",this);
gen=generator::type_id::create("gen");
endfunction

virtual task run_phase(uvm_phase phase);
phase.raise_objection(this);
gen.start(e.a.seqr);
#20;
phase.drop_objection(e.a.seqr);
endtask
endclass
`endif
