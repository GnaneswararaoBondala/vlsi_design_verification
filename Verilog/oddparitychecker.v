module mux2to1(
input [1:0]i,
input s,
output reg y);
begin
assign y=s?i[0]:i[1];
end
endmodule

module oddparitychecker(
input a,
input b,
input c,
output y);
wire w1,w2,w3;
mux2to1 g1({1'b0,1'b1},c,w1);
mux2to1 g2({c,w1},b,w2);
mux2to1 g3({w1,c},b,w3);
mux2to1 g4({w3,w2},a,y);
endmodule

module tb_paritycheck();
reg a,b,c;
wire y;
oddparitychecker inst1(a,b,c,y);
task f;
input m,n,o;
begin
a=m;
b=n;
c=o;
#10;
end
endtask
task chk(input x);
begin
if(y==x)
$display("Test passed,a=%b,b=%b,c=%b,y=%b",a,b,c,y);
end
endtask
initial begin
#10;
f(0,0,0);#10;chk(1);
f(0,0,1);#10;chk(0);
f(0,1,0);#10;chk(0);
f(0,1,1);#10;chk(1);
f(1,0,0);#10;chk(0);
f(1,0,1);#10;chk(1);
f(1,1,0);#10;chk(1);
f(1,1,1);#10;chk(0);
$finish;
end
endmodule
