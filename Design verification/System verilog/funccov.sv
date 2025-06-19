module tb_functional_coverage;
class random_data;
rand bit[3:0]x;
rand bit [3:0] y;
constraint c_x_y{
x inside {0,1,2,3,4,5};
y inside {6,7,8,9};
}
endclass
random_data rand_obj;
covergroup cg;
coverpoint rand_obj.x{
bins small_values={0,1,2};
bins medium_values={3,4,5};
}
cg cov;

coverpoint rand_obj.y;
cross rand_obj.x,rand_obj.y;
endgroup
initial begin
rand_obj=new();
cov=new();

for(int i=0;i<10;i++)
begin
if(rand_obj.randomize())
begin
cov.sample();
$display("x=%0d,y=%0d",rand_obj.x,rand_obj.y);
end
else
begin
$display("Randomization displayed");
end
end
$display("Coverage:%0d %%",cov.get_coverage());
end
endmodule

