


  module I2C_TOP_test;
    
  reg RESET;
  wire [6:0] ADRESS_OUT;
  wire [7:0] DATA_OUT;
  wire SCL;
  wire SDA;
    
    reg clk;
    reg sda;
    
   

    I2C_slave  dut (RESET,SCL,SDA,DATA_OUT,ADRESS_OUT);
     assign SCL=clk;
    assign SDA=dut.dir_en?1'bz:sda;
    
  // for initialzing input values
  task initialization; 
    begin 
      clk=0;
      sda=0;
      RESET=0;
    end
  endtask

      task rst;
        begin 
          RESET=1;
          repeat (2) @(negedge clk);
         
          #2;
          RESET=0;
        end
      endtask
      
 // clock generation
 always #10 clk=!clk;

 // task to generate start condition
  task start_gen;
  begin
    sda=1;
    @ (posedge clk); 
    #2;
   sda=0;
    @ (negedge clk);  
   end
 endtask

  // task to generate stop condtion
  task stop_gen;
    begin
      @ (negedge clk);
      sda=0;
      @(posedge clk); #2;
      sda=1;
    end
 endtask

  // task to generate adress values
      
        task wr_address;
          reg [7:0] temp;
      begin
      
        temp=8'b0000_1010;
        repeat (8) begin 
          @( posedge clk) ;
        sda=temp;
        temp=temp>>1;
        end
        end
  endtask

    
        task rd_address;
          reg [7:0] temp;
      begin
        temp=8'b0000_1011;
        repeat (8) begin 
          @( posedge clk) ;
        sda=temp;
        temp=temp>>1;
        end
        end
  endtask

  // task to generate write data values
  task write_data;
    reg [7:0] temp;
    
    begin
      temp=8'b 1100_1100;
      repeat (8) begin 
        @( posedge clk) ;
        sda=temp;
        temp=temp>>1;
      end
      end
 endtask

  // task to get read  data values
  task read_data;
    begin
      @( negedge clk) ;
      repeat(8) begin
        @ (negedge clk);
      end
    end
 endtask


  

  // calling all task
  initial begin
    initialization;
    rst;
    start_gen();
    
    wr_address();
    
    write_data;
    
    rd_address();
    @( negedge clk) ;
    read_data;
    #200;
    $finish;
end
initial begin
    // Dump waves
    $dumpfile("dump.vcd");
  $dumpvars(1);
end
  endmodule
  
      
