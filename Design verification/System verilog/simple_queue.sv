module queue;
int q1[$];
int q2[$];
initial begin
q1={1,2,3,4,5};
q1.insert(1,10);
$display("Elements in queue are %p",q1);
end
endmodule
