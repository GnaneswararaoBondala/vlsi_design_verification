module factorial(inp1,out1);
input [3:0]inp1;
output [31:0]out1;
reg [31:0]out_temp;
reg [3:0]index;
always @(*)
begin
out_temp=inp1;
for(index=inp1-1;index!=1;index=index-1)
out_temp=out_temp*index;
end
assign out1=out_temp;
endmodule

module factorial_test();
reg [3:0]inp1;
wire [31:0]out1;
factorial a1(inp1,out1);
initial begin
$monitor("value of input=%d,output=%d",inp1,out1);
inp1=4;
#5;
inp1=5;
#5;
inp1=8;
end
endmodule

