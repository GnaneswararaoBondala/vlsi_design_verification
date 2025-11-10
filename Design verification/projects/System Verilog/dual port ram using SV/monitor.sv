`include "transaction.sv"
`include "interface.sv"
`ifndef MONITOR_SV
`define MONITOR_SV
class monitor;
    transaction tr;
    mailbox mon2scb;
    virtual intf vif;

    function new(mailbox mon2scb, virtual intf vif);
        this.mon2scb = mon2scb;
        this.vif = vif;
    endfunction

    task run();
        forever begin
            @(posedge vif.clk);
            tr = new();
            tr.enb   = vif.enb;
            tr.wr    = vif.wr;
            tr.rd    = vif.rd;
            tr.w_addr = vif.w_addr;
            tr.w_data = vif.w_data;
            tr.r_addr = vif.r_addr;
            tr.r_data = vif.r_data;
            tr.display("MONITOR");
            mon2scb.put(tr);
        end
    endtask
endclass
`endif
