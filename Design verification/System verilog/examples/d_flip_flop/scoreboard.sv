class dff_scb;
  mailbox mon2scb;
  bit exp_q;
  
  function new(mailbox mon2scb);
    this.mon2scb=mon2scb;
  endfunction
  
  task run;
    transaction trans;
    forever begin
      mon2scb.get(trans);
      if(trans.rst)
        exp_q=0;
      else
        exp_q=trans.d;
      if(exp_q!=trans.q)
        $error("Mismatch expected q=%0b,Got=%0b",exp_q,trans.q);
      else
        $display("No mismatch expected q=%0b,Got q=%0b",exp_q,trans.q);
    end
  endtask
endclass
      
    