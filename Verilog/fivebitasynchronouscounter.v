module fivebitast(input clk,rst,output [4:0]q);

tff t1(clk,rst,1'b1,q[0]);
tff t2(q[0],rst,1'b1,q[1]);
tff t3(q[1],rst,1'b1,q[2]);
tff t4(q[2],rst,1'b1,q[3]);
tff t5(q[3],rst,1'b1,q[4]);
endmodule

module tff(input clk,rst,T,output reg q);
always @(posedge clk)
begin
if(rst)
q<=0;
else
begin
case(T)
1'b0:q=q;
1'b1:q=~q;
endcase
end
end
endmodule


module tb1;
reg clk,rst;
wire [4:0]q;

fivebitast uut(.clk(clk),.rst(rst),.q(q));

always #20 clk=~clk;
initial clk=0;
initial begin
rst=1;
#10;
rst=0;
#20;
end
endmodule

