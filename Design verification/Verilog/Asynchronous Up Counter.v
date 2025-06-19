module jkff(
input clk,
input rst,
input j,
input k,
output reg q,
output reg qbar);
assign qbar=~q;
always @(posedge clk or negedge rst)
begin
if(!rst)
q<=0;
else 
begin
case({j,k})
2'b00:q<=q;
2'b01:q<=0;
2'b10:q<=1;
2'b11:q<=qbar;
default:q<=q;
endcase
end
end
endmodule
module Asyn_counter(
input clk,
input rst,
input j,
input k,
output[3:0]q,
output[3:0]qbar);
jkff jk1(clk,rst,j,k,q[0],qbar[0]);
jkff jk2(qbar[0],rst,j,k,q[1],qbar[1]);
jkff jk3(qbar[1],rst,j,k,q[2],qbar[2]);
jkff jk4(qbar[2],rst,j,k,q[3],qbar[3]);
endmodule

module Asyn_count_tb;
reg clk,rst;
reg j,k;
wire [3:0] q,qbar;
Asyn_counter count(clk,rst,j,k,q,qbar);
initial begin
clk=0;
forever #5 clk=~clk;
end
initial begin
$monitor("clk=%0b,rst=%0b,j=%d,k=%d,q=%d,qbar=%d",clk,rst,j,k,q,qbar);
rst=0;
#10;
rst=1;j=1;k=1;
#200;
$finish;
end
endmodule
