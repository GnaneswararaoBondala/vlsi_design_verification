module tb;
  
  reg clk = 0;
  reg a, b, cin, sample;
   wire sum, cout, done;
  always #5 clk = ~clk;
  fulladd dut (
    .clk(clk),
    .a(a),
    .b(b),
    .cin(cin),
    .sample(sample),
    .sum(sum),
    .cout(cout),
    .done(done)
  );

  integer i;
  initial begin
    for (i = 0; i < 10; i++) begin
      @(posedge clk);
      a = $urandom_range(0,1);
      b = $urandom_range(0,1);
      cin = $urandom_range(0,1);
      sample = 1'b1;
      @(posedge clk);
      sample = 1'b0;
      @(posedge clk);
    end
  end

  property p1;
    logic lva, lvb, lvcin;
    logic lvsum, lvcout;
    @(posedge clk)
      ($rose(sample),
        lva = a, lvb = b, lvcin = cin,
        $display("Sampled a=%0d b=%0d cin=%0d at %0t", lva, lvb, lvcin, $time))
      |->
      ($rose(done)[->1],
        lvsum = sum, lvcout = cout,
        $display("Output sum=%0d cout=%0d at %0t", lvsum, lvcout, $time))
      ##0 (lvsum==(lva ^ lvb ^ lvcin) &&
           lvcout==((lva & lvb) | (lvb & lvcin) | (lvcin & lva)),
           $display("values of sum=%d,cout=%d,time=%d",lvsum,lvcout,$time));
  endproperty

  
  A1: assert property (p1)
    $info("Success at %0t", $time);
      else
        $error("Mismatch at %0t", $time);

  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb);
    #200;
    $finish;
  end
endmodule
