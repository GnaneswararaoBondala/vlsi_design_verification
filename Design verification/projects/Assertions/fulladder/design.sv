module fulladd(input clk,a,b,sample,cin,output reg sum,cout,done);
  
  
  always @(posedge clk)begin
    if(sample==1'b1) begin
      sum<=a^b^cin;
      cout<=(a&b)|(b&cin)|(cin&a);
      done<=1'b1;
    end
    else begin
      done<=1'b0;
    end
    
  end
endmodule