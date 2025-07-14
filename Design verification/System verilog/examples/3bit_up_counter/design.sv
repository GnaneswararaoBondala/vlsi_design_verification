module count (
    input clk,
    input rst,
    output reg [2:0] count
);

always @(posedge clk) begin
    if (rst)
        count <= 3'b000;  // Reset counter to 0
    else
        count <= count + 1;  // Increment counter
end

endmodule

