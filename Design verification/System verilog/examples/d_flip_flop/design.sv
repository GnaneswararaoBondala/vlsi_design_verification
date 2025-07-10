module dff(input clk,rst,d,output reg q,output qbar);
  always @(posedge clk)
    begin
      if(rst)
        q<=0;
      else
        q<=d;
    end
  assign qbar=~q;
endmodule
           