`include "transaction.sv"
`include "interface.sv"
`ifndef DRIVER_SV
`define DRIVER_SV
class driver;
    transaction tr;
    mailbox mbx;
    virtual intf vif;

    function new(mailbox mbx, virtual intf vif);
        this.mbx = mbx;
        this.vif = vif;
    endfunction

    task run();
        forever begin
            mbx.get(tr);
            @(posedge vif.clk);
            vif.enb    <= tr.enb;
            vif.wr     <= tr.wr;
            vif.rd     <= tr.rd;
            vif.w_addr <= tr.w_addr;
            vif.r_addr <= tr.r_addr;
            vif.w_data <= tr.w_data;
            @(posedge vif.clk);
            vif.enb <= 0;
            vif.wr <= 0;
            vif.rd <= 0;
        end
    endtask
endclass
`endif
