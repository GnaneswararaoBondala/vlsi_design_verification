class scoreboard;
  mailbox mon2scb;
  function new(mailbox mon2scb);
    this.mon2scb=mon2scb;
  endfunction
  task run();
    transaction trans;
    forever begin
      mon2scb.get(trans);
      if((trans.a+trans.b+trans.cin)=={trans.cout,trans.sum})
        $display("Result is as expected time=%0t",$time);
      else
        $error("Wrong result.\n\tExpected :%0d Actual:%0d time=%0t",(trans.a+trans.b+trans.cin),{trans.cout,trans.sum},$time);
    end
  endtask
endclass
