`include "uvm_macros.svh"
import uvm_pkg::*;

`include "environment.sv"
`include "sequence.sv"

//---------------- Test ----------------
class dff_test extends uvm_test;
  `uvm_component_utils(dff_test)

  dff_env      env;
  dff_sequence seq;

  function new(string name="dff_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = dff_env::type_id::create("env", this);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    seq = dff_sequence::type_id::create("seq");
    seq.start(env.agent.seqr);
    phase.drop_objection(this);
  endtask
endclass

