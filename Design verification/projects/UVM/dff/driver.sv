`ifndef DRIVER_SV
`define DRIVER_SV
`include "seq_item.sv"

`include "uvm_macros.svh"
import uvm_pkg::*;

//---------------- Driver ----------------
class dff_driver extends uvm_driver #(dff_seq_item);
  `uvm_component_utils(dff_driver)

  virtual dff_intf intf;

  function new(string name="dff_driver", uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual dff_intf)::get(this,"","vif",intf))
      `uvm_fatal("DRV", "Cannot get interface from config DB")
  endfunction

  task run_phase(uvm_phase phase);
    forever begin
      dff_seq_item tx;
      seq_item_port.get_next_item(tx);
      drive(tx);
      seq_item_port.item_done();
    end
  endtask

  task drive(dff_seq_item tx);
    @(posedge intf.clk);
    intf.rst <= tx.rst;
    intf.d   <= tx.d;
  endtask
endclass

`endif
