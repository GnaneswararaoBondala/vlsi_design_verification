module mailbox_example;
mailbox mbox;
int data;
initial begin
mbox=new();
fork
begin
for(int i=0;i<5;i++)
begin
$display("producer:sending data %0d",i);
mbox.put(i);
end
end
begin
for(int i=0;i<5;i++)
begin
mbox.get(data);
$display("receiver:receiving the data %0d",data);
end
end
join
end
endmodule
