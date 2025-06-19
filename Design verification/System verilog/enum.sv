module enum;
enum {IDLE=3,START,STOP} state_t;
string var_1;
initial begin
var_1=state_t.first;
end
endmodule
