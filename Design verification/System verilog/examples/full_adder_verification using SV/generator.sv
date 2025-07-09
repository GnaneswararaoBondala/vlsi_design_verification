`include "transaction.sv"
class generator;
  transaction tr;
  mailbox mbx;
  function new(mailbox mbx);
    this.mbx=mbx;
  endfunction
  task run();
    repeat(5)
      begin
        tr=new();
        tr.randomize();
        tr.display("Genertor class signals");
        mbx.put(tr);
      end
  endtask
endclass