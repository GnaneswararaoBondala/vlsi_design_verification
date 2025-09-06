`include "transaction.sv"
class generator;
  transaction tr;
  mailbox mbx;
  function new(mailbox mbx);
    this.mbx=mbx;
  endfunction
  task run();
    repeat(8) begin
      tr=new();
      assert(tr.randomize)
        else $error("[GEN] Randomization failed");
      mbx.put(tr);
      $display("[GEN] Generator signals=%0b",tr.in);
    end
  endtask
endclass
    
  