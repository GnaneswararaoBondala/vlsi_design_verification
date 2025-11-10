`ifndef MONITOR_SV
`define MONITOR_SV
`include "seq_item.sv"
`include "uvm_macros.svh"
import uvm_pkg::*;

//---------------- Monitor ----------------
class dff_monitor extends uvm_monitor;
  `uvm_component_utils(dff_monitor)

  virtual dff_intf intf;
  uvm_analysis_port #(dff_seq_item) item_collected_port;

  function new(string name="dff_monitor", uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    item_collected_port = new("item_collected_port",this);
    if(!uvm_config_db#(virtual dff_intf)::get(this,"","vif",intf))
      `uvm_fatal("MON","Cannot get interface from config DB");
  endfunction

  task run_phase(uvm_phase phase);
  dff_seq_item tx;  // ? declaration moved here
  forever begin
    @(posedge intf.clk);
    #1; // optional delta delay so q is updated
    tx = dff_seq_item::type_id::create("tx", this);
    tx.rst = intf.rst;
    tx.d   = intf.d;
    tx.q   = intf.q;
    item_collected_port.write(tx);
  end
endtask
endclass


`endif

