`include "environment.sv"
`include "interface.sv"

module test_mips32;
  reg clk1, clk2;
  integer k;

  mips_if mif(clk1, clk2);
  env env_h;

  pipe_MIPS32 mips(.clk1(clk1), .clk2(clk2));

  initial begin
    clk1 = 0; clk2 = 0;
    forever begin
      #5 clk1 = ~clk1;
      #5 clk2 = ~clk2;
    end
  end

  initial begin
    // Bind interface signals to DUT manually
    force mips.HALTED = mif.HALTED;
    force mips.TAKEN_BRANCH = mif.TAKEN_BRANCH;
    force mips.PC = mif.PC;
    for (k = 0; k < 32; k++)
      force mips.Reg[k] = mif.Reg[k];
    for (k = 0; k < 1024; k++)
      force mips.Mem[k] = mif.Mem[k];
  end

  initial begin
    env_h = new(mif);
    env_h.run();
  end

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, mips);
    #1000 $finish;
  end
endmodule

