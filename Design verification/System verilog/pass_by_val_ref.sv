module pass_by_val_ref;

task swap_by_val(input bit[1:0]a,input bit[1:0]b);
bit[1:0]temp;
temp=a;
a=b;
b=temp;
$display("Pass by value -a:%0d,b:%0d",a,b);
endtask

task automatic swap_by_ref(ref bit [1:0]a,ref bit[1:0]b);
bit[1:0]temp;
temp=a;
a=b;
b=temp;
$display("Pass by reference -a :%0d,b:%0d",a,b);
endtask

task automatic swap_const_ref(const ref bit[1:0]a,ref bit[1:0]b);
bit [1:0]temp;
temp=a;
//a=b since a is constant
b=temp;
$display("Const ref-a:%0d,b:%0d",a,b);
endtask

bit[1:0]a;
bit[1:0]b;

initial begin
a=1;
b=2;
swap_by_val(a,b);
$display("After pass by value -a:%0d,b-%0d",a,b);
swap_by_ref(a,b);
$display("After pass by reference-a:%0d,b-%0d",a,b);
swap_const_ref(a,b);
$display("After constant ref -a:%0d,b-%0d",a,b);
end
endmodule
