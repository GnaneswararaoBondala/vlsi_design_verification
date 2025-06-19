module spi_state(
input wire clk,
input wire reset,
input wire[15:0]datain,//Binary input vector
output wire spi_cs_l,
output wire spi_sclk,
output wire spi_data,//spi bus data
output wire [4:0]counter);

reg[15:0]MOSI;//SPI shift register
reg[4:0]count;
reg cs_l;
reg sclk;
reg [2:0]state;


always @(posedge clk or posedge reset)
if(reset) begin
MOSI<=16'b0;
count<=5'd16;
cs_l<=1'b1;
sclk<=1'b0;
end

else begin
case(state)

0:begin
sclk<=1'b0;
cs_l<=1'b1;
state<=1;
end

1:begin
sclk<=1'b0;
cs_l<=1'b0;
MOSI<=datain[count-1];
count<=count-1;
state<=2;
end

2:begin
sclk<=1'b1;
if(count>0)
state<=1;
else begin
count<=16;
state<=0;
end
end


default:state<=0;
endcase
end


assign spi_cs_l=cs_l;
assign spi_sclk=sclk;
assign spi_data=MOSI;
assign counter=count;
endmodule 

module tb_spi_state;
reg clk;
reg reset;
reg [15:0]datain;


wire spi_cs_l;
wire spi_sclk;
wire spi_data;
wire [4:0]counter;


spi_state dut(.*);
initial begin
clk=0;
reset=1;
datain=0;
end

always #5 clk=~clk;
initial begin
#10 reset=1'b0;
#10 datain=16'hA569;
#335 datain=16'h2563;
#335 datain=16'h9B63;
#335 datain=16'h6A61;

#335 datain=16'hA265;
#335 datain=16'h7564;
end
endmodule





