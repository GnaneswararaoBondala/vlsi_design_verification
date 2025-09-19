`include "transaction.sv"
class scoreboard;
    transaction tr;
    mailbox mon2scb;
    logic [7:0] ref_mem [0:15];

    function new(mailbox mon2scb);
        this.mon2scb = mon2scb;
        foreach (ref_mem[i]) ref_mem[i] = 8'h00;
    endfunction

    task run();
        forever begin
            mon2scb.get(tr);
            if (tr.wr) ref_mem[tr.w_addr] = tr.w_data;
            if (tr.rd) begin
                if (tr.r_data === ref_mem[tr.r_addr])
                    $display("[%0t] PASS: r_addr=%0d data=0x%0h", $time, tr.r_addr, tr.r_data);
                else
                    $display("[%0t] FAIL: r_addr=%0d got=0x%0h exp=0x%0h",
                             $time, tr.r_addr, tr.r_data, ref_mem[tr.r_addr]);
            end
        end
    endtask
endclass
