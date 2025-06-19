module static_task_example;
int i;
task increment();
i=i+1;
endtask
initial begin
increment();
$display("the value of i is %d after first",i);
increment();
$display("the value of i is %d after second",i);
end
endmodule
