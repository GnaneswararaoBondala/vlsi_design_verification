class transaction;
  randc bit a;
  randc bit b;
  randc bit cin;
  bit sum;
  bit cout;
  function void display(string name);
    $display("_______%s______",name);
    $display("a=%b,b=%b,cin=%b,sum=%b,cout=%b,time=%0t",a,b,cin,sum,cout,$time);
  endfunction
endclass