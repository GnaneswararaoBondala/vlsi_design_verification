module APB_Memory_TB;
  reg Pclk;
  reg Prst;
  reg [5:0] Paddr;
  reg Pselx;
  reg Penable;
  reg Pwrite;
  reg [31:0]Pwdata;
  
  wire Pready;
  wire Pslverr;
  wire [31:0]Prdata;
  
  APB_Memory dut(Pclk,Prst,Paddr,Pselx,Penable,Pwrite,Pwdata,Pready,Pslverr,Prdata);
  
  initial Pclk=1;
  always #10 Pclk=~Pclk;
  
  
  task reset_and_initialization;
    begin
      #5 Prst=0;
      @(posedge Pclk);
      Prst=1;
      Pselx=1'b0;
      Penable=1'bx;
      Pwrite=1'bx;
      Paddr='bx;
    end
  endtask
  
  task write_transfer;
    begin
      Pselx=1;
      Pwrite=1;
      Pwdata=$random;
      Paddr=$random;
      
      @(posedge Pclk);
      Penable=1;
      wait(Pready==1)
      
      @(posedge Pclk)
      Penable=0;
      $strobe("Writing data into memory data_wr=%0d adress_rd=%0d",Pwdata,Paddr);
    end
  endtask
  
  task read_transfer;
    begin
      Pselx=1;
      Pwrite=0;
      @(posedge Pclk);
      Penable=1;
      Pwrite=Pwrite;
      Penable=Penable;
      Paddr=Paddr;
      Pwdata=Pwdata;
      @(posedge Pclk);
      Penable=0;
      Pselx=0;
      $strobe("Reading data from memory data_rd=%0d address_rd=%0d",Prdata,Paddr);
    end
  endtask
  
  task read_write_transfer;
    begin
      repeat(2)
        begin
          write_transfer;
          read_transfer;
        end
    end
  endtask
  
  initial begin
    reset_and_initialization;
    read_write_transfer;
    
    #80; 
    $finish;
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
endmodule