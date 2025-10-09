`include "transaction.sv"
`include "interface.sv"
class driver;

  virtual fifo_if.Tb vif;   
  mailbox gen2drv;

  function new(virtual fifo_if.Tb vif, mailbox gen2drv);
    this.vif = vif;
    this.gen2drv = gen2drv; 
  endfunction

  task run();
    transaction tr;

    forever begin
      gen2drv.get(tr);

      // WRITE
      if (tr.wr_en) begin
        @(posedge vif.wr_clk);
        if (!vif.full && !vif.wr_rst) begin
          vif.wr_en <= 1;
          vif.data_in <= tr.data;
          @(posedge vif.wr_clk);
          vif.wr_en <= 0;
          $display("[DRV] WRITE: data=%0d @%0t", tr.data, $time);
        end
        else
          $display("[DRV] WRITE skipped: FULL or RESET @%0t", $time);
      end

      // READ
      if (tr.rd_en) begin
        @(posedge vif.rd_clk);
        if (!vif.empty && !vif.rd_rst) begin
          vif.rd_en <= 1;
          @(posedge vif.rd_clk);
          vif.rd_en <= 0;
          $display("[DRV] READ triggered @%0t", $time);
        end
        else
          $display("[DRV] READ skipped: EMPTY or RESET @%0t", $time);
      end
    end
  endtask

endclass