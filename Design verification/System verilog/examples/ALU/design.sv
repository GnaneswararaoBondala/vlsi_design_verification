module alu(input [2:0]a,b,input [2:0]sel,output reg [4:0]out);
  always @(*)
    begin
      case(sel)//taking different mathematical functions based on selection
        3'b000:out=a+b;
        3'b001:out=a-b;
        3'b010:out=a&b;
        3'b011:out=a^b;
        3'b100:out=a|b;
        3'b101:out=~(a&b);
        3'b110:out=~(a|b);
        3'b111:out=a%b;
        default:out='bx;
      endcase
    end
endmodule