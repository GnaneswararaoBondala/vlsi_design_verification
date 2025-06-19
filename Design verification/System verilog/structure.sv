module structure;
struct{
int id;
logic [7:0]grade;
string name;
}student_t;
initial begin
student_t.id=101;
student_t.grade=8'b11011101;
student_t.name="John Doe";
$display("ID:%0d,Grade:%0b,Name:%s",student_t.id,student_t.grade,student_t.name);
end
endmodule

