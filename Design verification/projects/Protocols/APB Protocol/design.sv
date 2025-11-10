module APB_Memory(Pclk,Prst,Paddr,Pselx,Penable,Pwrite,Pwdata,Pready,Pslverr,Prdata,temp);
  
  //Input signals
  input Pclk;
  input Prst;
  input Pselx;
  input Penable;
  input Pwrite;
  input [31:0] Pwdata;
  input [5:0] Paddr;
  
  //Output signals
  output reg Pready;
  output reg Pslverr;
  output reg [31:0] Prdata;
  output reg [31:0] temp;
  
  reg [31:0]mem[31:0];
  
  parameter [1:0]idle=2'b00;
  parameter [1:0]setup=2'b01;
  parameter [1:0]access=2'b10;
  
  reg [1:0]present_state,next_state;
  
  always @(posedge Pclk or negedge Prst)
    begin
      if(Prst==0)
        begin
          present_state<=idle;
          next_state<=present_state;
        end
      else
        present_state<=next_state;
    end
  
  //state logic
  always @(*) begin
    case(present_state)
      idle:begin
        next_state=setup;
      end
      
      setup:begin
        if(Pselx) begin
          next_state=access;
        end
        else begin
          next_state=idle;
        end
      end
      
      access:begin
        Pready=1;
        if(Penable & Pwrite)
          begin
            if(Paddr>31) Pslverr=1;
            else
              begin
                mem[Paddr]=Pwdata;
                temp=mem[Paddr];
                Pslverr=0;
              end
          end
        else if(Penable & Pwrite==0)
          begin
            Prdata=mem[Paddr];
          end
        else if(!Penable) begin
          next_state=setup;
        end
      end
    endcase
  end
endmodule
        
         