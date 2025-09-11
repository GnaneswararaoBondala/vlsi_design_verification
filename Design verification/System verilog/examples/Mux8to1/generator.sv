`include "transaction.sv"
class generator;
  transaction tr;
  mailbox mbx;
  int count;

  function new(mailbox mbx);
    this.mbx   = mbx;
  endfunction

  task run();
    repeat (8) begin
      tr = new();
      assert(tr.randomize());
      mbx.put(tr);
      $display("Generator sent: in=%0b sel=%0b", tr.in, tr.sel);
    end
  endtask
endclass
