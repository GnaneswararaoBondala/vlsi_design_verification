module clockgen;
reg clk;
initial begin
clk=0;
end
always begin
#5clk=~clk;
$display("The value of clock is %d",clk);
end
endmodule
