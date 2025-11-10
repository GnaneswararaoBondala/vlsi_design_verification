`include "uvm_macros.svh"
import uvm_pkg::*;
`include "interface.sv"
`include "transaction.sv"
`include "test.sv"
`include "scoreboard.sv"
`include "monitor.sv"
`include "generator.sv"
`include "environment.sv"
`include "driver.sv"
`include "design.sv"
`include "agent.sv"
module tb;
mul_if mif();
mul dut(.a(mif.a),.b(mif.b),.y(mif.y));
initial begin
uvm_config_db#(virtual mul_if)::set(null,"*","mif",mif);
run_test("test");
end
endmodule

