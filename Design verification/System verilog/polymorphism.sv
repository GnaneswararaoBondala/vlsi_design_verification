module polymorphism_ex;
class base_class;
 function void display();
$display("Inside base class");
endfunction
endclass

class ext_class1 extends base_class;
function void diplay();
$display("Inside extended class 1");
endfunction
endclass

class ext_class2 extends base_class;
function void display();
$display("Inside extended class 2");
endfunction
endclass

class ext_class3 extends base_class;
function void display();
$display("Inside extended class 3");
endfunction
endclass

initial begin
ext_class1 ec_1=new();
ext_class2 ec_2=new();
ext_class3 ec_3=new();
base_class b_c[3];

b_c[0]=ec_1;
b_c[1]=ec_2;
b_c[2]=ec_3;

b_c[0].display();
b_c[1].display();
b_c[2].display();
end

endmodule
