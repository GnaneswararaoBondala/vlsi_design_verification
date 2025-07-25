module tb;
  bit clk,rst,valid,a;
  always #5 clk=~clk;
  initial begin
    rst=1;
    valid=0;
    a=0;
    #20;
    
    rst=0;
    #25;
    valid=1;
    #10;
    valid=0;
    a=1;
    #40;
    a=0;
  end
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,tb);
  end
  
  property p1;
    @(posedge clk)
    disable iff(rst)
    $rose(valid)|=>a[*3:6];
  endproperty
  
  assert property(p1)
    begin
      $display("Assertion passed at time %0t",$time);
    end
    else
      begin
        $display("Assertion failed at time %0t",$time);
      end
    
    initial begin
      #200;
      $finish;
    end
    endmodule
    
    
    