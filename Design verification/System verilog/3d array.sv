module d3pd;
bit [2:0][3:0][7:0]data;
initial begin
data=96'hffff_ffff_ffef_ffef_aaaa_aaaa_bbbb_bbbb;
$display("the value of data is %h",data);
foreach(data[i])
begin
$display("data[%0d]=%b",i,data[i]);
foreach(data[i][j])
begin
$display("data[%0d][%0d]=%b",i,j,data[i][j]);
end
end
end
endmodule

