class first;
int data;
endclass

module objectcopy;
first f1;
first p1;

initial begin
f1=new();
f1.data=36;
p1=new f1;
$display("the value of data is %d",p1.data);

p1.data=12;
$display("value of data is %0d",f1.data);
end
endmodule
