module lfsr(input clk,rst,output reg q1,q2,q3,q4);
wire d=q1^q4;
always @(posedge clk)
begin
if(rst) begin
q1<=1'b1;
q2<=1'b0;
q3<=1'b0;
q4<=1'b0;
end
else begin
q4<=q3;
q3<=q2;
q2<=q1;
q1<=d;
end
end
endmodule


module lfsr_tb;
reg clk,rst;
wire q1,q2,q3,q4;
lfsr dut(clk,rst,q1,q2,q3,q4);
always #5 clk=~clk;
initial begin
clk=0;
rst=1;
#20;
rst=0;
#200;
$finish;
end
initial begin
$monitor("Time=%0t|q1 q2 q3 q4=%b %b %b %b",$time,q1,q2,q3,q4);
end
endmodule