`include "uvm_macros.svh"
import uvm_pkg::*;
`ifndef MONITOR_SV
`define MONITOR_SV

`include "transaction.sv"
class mon extends uvm_monitor;
`uvm_component_utils(mon)

uvm_analysis_port#(transaction) send;
transaction tr;
virtual mul_if mif;
function new(input string inst="mon",uvm_component parent=null);
super.new(inst,parent);
endfunction

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
tr=transaction::type_id::create("tr");
send=new("send",this);
if(!uvm_config_db#(virtual mul_if)::get(this," ","mif",mif))
`uvm_error("drv","unable to access interface");
endfunction

virtual task run_phase(uvm_phase phase);
forever begin
#20;
tr.a=mif.a;
tr.b=mif.b;
tr.y=mif.y;
`uvm_info("MON",$sformatf("a:%0d b:%0d y:%0d",tr.a,tr.b,tr.y),UVM_NONE);
send.write(tr);
end
endtask
endclass
`endif
