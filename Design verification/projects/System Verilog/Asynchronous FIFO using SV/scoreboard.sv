`include "transaction.sv"
`include "interface.sv"
class scoreboard #(parameter data_width = 8);

  bit [data_width-1:0] expected_q[$];
  mailbox mon2scb;
  virtual fifo_if vif;

  function new(mailbox mon2scb);
    this.mon2scb = mon2scb;
  endfunction

  task run();
    transaction tr;
    forever begin
      mon2scb.get(tr);

      // WRITE
      if (tr.wr_en && !tr.rd_en) begin
        expected_q.push_back(tr.data);
        $display("[SCB] WRITE: expected_q <= %0d", tr.data);
      end

      // READ
      else if (tr.rd_en && !tr.wr_en) begin
        if (expected_q.size() > 0) begin
          bit [data_width-1:0] expected_val = expected_q.pop_front();
          if (expected_val == tr.data)
            $display("[SCB][PASS] READ matched: expected=%0d, got=%0d", expected_val, tr.data);
          else
            $display("[SCB][FAIL] READ mismatched: expected=%0d, got=%0d", expected_val, tr.data);
        end
        else begin
          $display("[SCB][WARN] UNDERFLOW: read occurred but queue empty");
        end
      end
    end
  endtask

endclass