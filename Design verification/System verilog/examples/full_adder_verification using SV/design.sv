module fa(input a,b,cin,output reg sum, output reg cout);
  always @(*)
     begin
      sum=a^b^cin;
      cout=((a&b)|(b&cin)|(cin&a));
    end
endmodule
  