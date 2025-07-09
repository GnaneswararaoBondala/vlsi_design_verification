module tb;
  int done_count=0;
  event done_evt;
  
  initial begin
    fork_block:fork
      begin
        #10;
        done_count++;
        ->done_evt;
        $display("p1 finished at %0t",$time);
      end
      
      begin
        #20;
        done_count++;
        ->done_evt;
        $display("p2 finished at %0t",$time);
      end
      
      begin
        #30;
        done_count++;
        ->done_evt;
        $display("p3 finished at %0t",$time);
      end
      
      begin
        forever
          begin
            @done_evt;
            if(done_count==2)
              disable fork_block;
          end
      end
    join
  end
endmodule

        