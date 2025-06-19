module automatic_task;
int a=0;
task automatic increment();
integer i=0;
i=i+1;
a=a+1;
$display("the value of i is %d",i);
$display("the value of a is %d",a);
endtask
initial begin
increment();
increment();
end
endmodule
