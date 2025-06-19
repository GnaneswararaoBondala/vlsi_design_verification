module ring_and_johnsoncounter(
input clk,
input rst,
output reg[0:3]q);
always @(posedge clk)
begin
if(rst)
q<=4'b1000;
else
begin
q<={~q[3],q[0:2]};
end
end
endmodule


module ring_counter_tb();
reg clk,rst;
wire [0:3]q;
ringcounter dut(.clk(clk),.rst(rst),.q(q));
always #5 clk=~clk;
initial begin
clk=1'b0;
rst=1'b1;
#20;
rst=0;
end
initial begin
$monitor("time=%0t,clk=%b rst=%b q=%b",$time,clk,rst,q);
#150;
$finish;
end
endmodule

