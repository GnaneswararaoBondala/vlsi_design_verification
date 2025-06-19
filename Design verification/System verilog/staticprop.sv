module staticprop;
class example;
static int a;
static int b;
endclass

example ex_h1,ex_h2;
ex_h1=new();
ex_h2=new();
ex_h1.a=20;
ex_h1.b=30;
$display("the value of a is %d",ex_h1.a);
endmodule
