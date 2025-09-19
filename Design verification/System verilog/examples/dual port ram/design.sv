module dpramverin(
    clk,
    rstn,
    enb,
    wr,
    rd,
    w_addr,
    r_addr,
    w_data,
    r_data
);

    input  clk;
    input  rstn;
    input  enb;
    input  wr;
    input  rd;
    input  [4:0]  w_addr;
    input  [4:0]  r_addr;
    input  [7:0]  w_data;
    output reg [7:0]  r_data;

    integer i;
    reg [7:0] mem [0:15];   

    always @(posedge clk) begin
        if (!rstn) begin
            for (i = 0; i < 16; i=i+1) mem[i] <= 8'b0;   
            r_data <= 8'b0;
        end
        else if (enb) begin
            if (wr && rd) begin
                mem[w_addr[3:0]] <= w_data;
                if (w_addr == r_addr)
                    r_data <= w_data;
                else
                    r_data <= mem[r_addr[3:0]];
            end
            else if (wr)
                  mem[w_addr[3:0]] <= w_data;
            else if (rd) 
                   r_data <= mem[r_addr[3:0]];
        end
    end
endmodule
