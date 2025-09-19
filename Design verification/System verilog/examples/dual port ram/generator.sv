`include "transaction.sv"
`ifndef GENERATOR_SV
`define GENERATOR_SV
class generator;
    transaction tr;
    mailbox mbx;
    logic [4:0] last_w_addr;

    function new(mailbox mbx);
        this.mbx = mbx;
    endfunction

    task write();
        tr = new();
        tr.randomize();
        tr.wr = 1; tr.rd = 0;
        last_w_addr = tr.w_addr;
        mbx.put(tr);
        tr.display("GEN WRITE");
    endtask

    task read();
        tr = new();
        tr.randomize();
        tr.wr = 0; tr.rd = 1;
        tr.r_addr = last_w_addr;
        mbx.put(tr);
        tr.display("GEN READ");
    endtask

    task write_then_read();
        write();
        #1;
        read();
    endtask
endclass
`endif
