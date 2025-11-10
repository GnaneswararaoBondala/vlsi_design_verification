`include "uvm_macros.svh"
import uvm_pkg::*;
`include "agent.sv"
`include "monitor.sv"
`include "scoreboard.sv"
`ifndef ENVIRONMENT_SV
`define ENVIRONMENT_SV

class environment extends uvm_env;
`uvm_component_utils(environment)

function new(input string inst="environmet",uvm_component parent);
super.new(inst,parent);
endfunction

agent a;
sco s;
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
a=agent::type_id::create("a",this);
s=sco::type_id::create("s",this);
endfunction

virtual function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
a.m.send.connect(s.recv);
endfunction
endclass
`endif