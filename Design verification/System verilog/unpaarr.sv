module unpacarr;
reg [3:0]unpacked_array;
initial begin
unpacked_array={10,20,30,40};
foreach(unpacked_array[i])
begin
$display("data[%0d]=%d",i,unpacked_array[i]);
end
end
endmodule

