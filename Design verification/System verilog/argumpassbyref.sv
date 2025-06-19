module task_ex_pass_by_value;
int x,y,z;
task automatic example(ref int x,y);
x=x+y;
$display("the value of x,y inside the task are %d %d",x,y);
endtask
initial begin
x=0;
y=1;
example(x,y);
$display("the value of x and y outside the task are %d %d",x,y);
end
endmodule
