module demux1to8(
input in,
input [2:0]sel,
output reg [7:0]out);
initial begin
out=8'b0;
end
always @(*)
case(sel)
3'b000:out[0]=in;
3'b001:out[1]=in;
3'b010:out[2]=in;
3'b011:out[3]=in;
3'b100:out[4]=in;
3'b101:out[5]=in;
3'b110:out[6]=in;
3'b111:out[7]=in;
default:out=1'b0;
endcase
endmodule

module demux1to8_tb;
reg in;
reg [2:0] sel;
wire [7:0]out;
demux1to8 uut(.in(in),.sel(sel),.out(out));
initial begin
in=0;
sel=3'b000;
#100;
sel=3'b001;
#100;
sel=3'b010;
#100;
sel=3'b011;
#100;
sel=3'b100;
#100;
sel=3'b101;
#100;
sel=3'b110;
#100;
sel=3'b111;
#100;
end
endmodule

