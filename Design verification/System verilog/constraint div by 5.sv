class div_by_5;
rand bit [5:0]a;
constraint c1{a%5==0;}
endclass
module div_by_5;
div_by_5 ch;
initial begin
ch=new();
repeat(10) begin
ch.randomize();
$display("value of a=%0d",ch.a);
end
end
endmodule
