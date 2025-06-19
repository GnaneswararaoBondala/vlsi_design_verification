class Baseclass;
int data;
function void display();
$display("Base class data:%0d",data);
endfunction
endclass
class DerivedClass extends Baseclass;
int extra_data;
function void show();
$display("Derived class data:%0d",extra_data);
endfunction
endclass
module inheritance;
initial begin
static DerivedClass dobj=new();
dobj.data=10;
dobj.extra_data=20;
dobj.display();
dobj.show();
end
endmodule

