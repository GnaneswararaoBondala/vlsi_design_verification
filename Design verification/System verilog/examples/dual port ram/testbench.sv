`include "interface.sv"
`include "environment.sv"
//`include "design.sv"

module top;
    logic clk, rstn;
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        rstn = 0;
        repeat(2) @(posedge clk);
        rstn = 1;
    end

    intf pif(clk, rstn);

    dpramverin dut(
        .clk(pif.clk), .rstn(pif.rstn),
        .enb(pif.enb), .wr(pif.wr), .rd(pif.rd),
        .w_addr(pif.w_addr), .r_addr(pif.r_addr),
        .w_data(pif.w_data), .r_data(pif.r_data)
    );

    initial begin
        pif.enb=0; pif.wr=0; pif.rd=0;
        pif.w_addr=0; pif.r_addr=0; pif.w_data=0;
    end

    environment env;
    initial begin
        env = new(pif);
        env.run();
    end

    initial begin
        #500 $finish;
    end
endmodule
