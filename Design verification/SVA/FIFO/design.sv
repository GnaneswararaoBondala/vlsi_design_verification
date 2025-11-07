module FIFO
 #( parameter FIFO_DEPTH = 16,
  parameter FIFO_WIDTH = 8)
  
  (input clk,rst_n,wr_en,rd_en,
  input [FIFO_WIDTH-1:0] data_in,

  output reg [FIFO_WIDTH-1:0] data_out,
  output reg wr_ack,
  output reg overflow,
  output full,empty,almostfull,almostempty,underflow
);

  localparam addr = $clog2(FIFO_DEPTH);

  reg [FIFO_WIDTH-1:0] mem [0:FIFO_DEPTH-1];

  reg [addr-1:0] wr_ptr;
  reg [addr-1:0] rd_ptr;
  reg [addr:0]   count;

  always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
      wr_ptr <= 0;
      wr_ack <= 0;
      overflow <= 0;
    end else begin
      if(wr_en && !full) begin//Write operation
        mem[wr_ptr] <= data_in;
        wr_ptr <= wr_ptr + 1;
        wr_ack <= 1;
        overflow <= 0;
      end else begin
        wr_ack <= 0;
        overflow <= (wr_en && full);
      end
    end
  end

   always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
      rd_ptr <= 0;
      data_out <= 0;
    end else begin
      if(rd_en && !empty) begin//read pointer
        data_out <= mem[rd_ptr];
        rd_ptr <= rd_ptr + 1;
      end
    end
  end

  always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
      count <= 0;
    end else begin
      case ({wr_en, rd_en})
        2'b10: if (!full )  count <= count + 1; 
        2'b01: if (!empty)  count <= count - 1; 
        default: count <= count;
      endcase
    end
  end

  assign full        = (count == FIFO_DEPTH);
  assign empty       = (count == 0);
  assign underflow   = (rd_en && empty);
  assign almostfull  = (count == FIFO_DEPTH-2);
  assign almostempty = (count == 1);

endmodule
