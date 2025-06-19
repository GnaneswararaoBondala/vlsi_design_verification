module d2pd;
bit [3:0][7:0]data;
initial begin
data=32'hffef_ffef;
$display("the value of data is %b",data);
foreach(data[i])
$display("data[%0d]=%h",i,data[i]);
end
endmodule


