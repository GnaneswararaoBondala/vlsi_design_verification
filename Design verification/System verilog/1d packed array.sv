module example;
bit [7:0] data;
initial begin
data=8'b11011101;
for(int i=0;i<$size(data);i++)
$display("data[%0d]=%b",i,data[i]);
end
endmodule
