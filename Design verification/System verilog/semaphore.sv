module semaphore_ex;
semaphore sema;
initial begin
sema=new(3);
fork
display_1;
display_2;
join
end
task automatic display_1;
sema.get(1);
$display("%t:Task display_1:Got 1 key",$time);
#5;
sema.put(1);
$display("%t:Task display_1:Put 1 key",$time);
endtask
task automatic display_2;
sema.get(3);
$display("%t:task display_2:Got 3 keys",$time);
sema.put(2);
$display("%t:Task display_2:Put 2 keys",$time);
endtask
endmodule
