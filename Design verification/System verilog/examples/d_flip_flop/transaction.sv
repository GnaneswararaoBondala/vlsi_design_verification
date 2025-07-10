class transaction;
  rand bit rst;
  rand bit d;
  bit q;
  bit qbar;
  function void display(string name);
    $display("_____%s____",name);
    $display("rst=%b,d=%b,q=%b,qbar=%b, at time=%0t",rst,d,q,qbar,$time);
  endfunction
endclass
  