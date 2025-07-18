

  module I2C_slave(RESET_IN,SCL,SDA,DATA_OUT,ADRESS_OUT);
 
  input RESET_IN;
    output [6:0] ADRESS_OUT;
  output [7:0] DATA_OUT;
  inout SCL;
  inout SDA;
    
    //  signal delcaration 
    wire wr_rd; // 0: write , 1 read
    reg  [7:0] adress_in;// for the adress and write_read signal
    reg  [7:0] wr_data;  // for the data in while writing
    reg  [7:0] rd_data;  // data_out while reading
    
    reg  [7:0] sipo_data;// register to convert serila to parallel
    reg  [7:0] piso_data;
    
    reg  [3:0]  count; // to count upto 8.
    reg  [3:0]  present_state;
    reg  [3:0]  next_state;
    
    reg   sda_out;// serial data out from slave
    reg   dir_en;// 0:data from master to slave.1 data from slave to master
    reg  [7:0] mem [255:0];
    
    reg wr_en;
    reg rd_en;
    reg start;
    reg stop;
    reg count_en;
    reg sipo_en;
    reg piso_en;
    reg sipo_valid;
    reg stop_en;
    reg piso_valid;
    reg start_en;
    

  // parameter declaration to state
  parameter  state_idle          =4'b0000,
             state_start         =4'b0001,
             state_reg_addr      =4'b0010,
             state_reg_addr_ack  =4'b0011,
             state_write         =4'b0100,
             state_write_ack     =4'b0101,
             state_read          =4'b0110,
             state_read_ack      =4'b0111,
             state_stop          =4'b1000,
             state_stop_m        =4'b1001;
    
    assign SDA=dir_en?sda_out:1'bz;
    assign DATA_OUT=rd_data;
    assign {ADRESS_OUT,wr_rd}=adress_in;
    
    
    // logic to change state
    always @ (negedge SCL or posedge RESET_IN ) begin
      if(RESET_IN) present_state <=state_idle;
      else begin 
        present_state<=next_state;
      end
    end
    
    // counter logic
    always @ (negedge SCL or posedge RESET_IN ) begin
      if(RESET_IN) count<=0;
      else begin
        if (count_en) count<=count+1;
        else count<=0;
       end
    end
    
    //logic for slave memory 
    always @ (negedge SCL or posedge RESET_IN ) begin
      if(!RESET_IN) begin 
        if(wr_en) mem[ADRESS_OUT]<=wr_data;
        else if (rd_en) rd_data<=mem[ADRESS_OUT];
     end
   end
    
    //start condition
    always @ (negedge SDA) begin 
      //start<=0;
      if (SCL ) start<=1;
    end
    
    // stop condition 
    always @( posedge SDA) begin 
     stop<=0;
       if(SCL && stop_en) stop<=1;
    end
    
    //always block for next state 
    always @ (*) begin
      case(present_state) 
        state_idle:  begin 
          				if (start) next_state=state_start;
          				else next_state=state_idle;
        			  end
        
        state_start     :begin 
                          next_state=state_reg_addr;
                        end

      state_reg_addr   :begin
                          // waiting for 8 clk period
        if(count>=0 && count<6) begin    
                            next_state=state_reg_addr;
                          end
                          else begin  
                            next_state=state_reg_addr_ack;
                          end
                       end
                 
                    
    state_reg_addr_ack : //slave will generate ack 
                         begin
                          if (sda_out==0) begin //ack
                            if(wr_rd==0)begin //write
                              next_state=state_write;
                             end
                             else begin //read
                              next_state=state_read;
                             end
                           end
                          else begin // nack
                             next_state=state_stop_m;
                             end
                        end
                    
     state_write     :// write state
                      begin
                        // waiting for 8 clk period
                        if(count>=0 && count<6) begin    
                           next_state=state_write;
                         end
                         else begin  
                           next_state=state_write_ack;
                          end
                       end
             
    state_write_ack  : //slave will generate ack 
                     begin 
                        if (sda_out==0) next_state=state_reg_addr;
                       
                         else next_state=state_stop_m;
                      end
    state_read        :// read state
                       begin
                          // waiting for 8 clk period
                         if(count>=0 && count<6) begin    
                            next_state=state_read;
                          end
                          else begin  
                            next_state=state_read_ack;
                          end
                       end
             
    state_read_ack  : //master  will generate ack 
                      begin 
                        if (SDA==0) next_state=state_reg_addr;
                         else next_state=state_stop_m;
                      end
                     
        state_stop_m:  begin 
          if (stop) next_state=state_stop;
        else if (start) next_state=state_start;
        end
        
    state_stop      : begin if (start) next_state=state_start;
                        else next_state=state_stop;
                      end
        default: next_state=state_idle;
    endcase
    end

 //always block for output 
    always @ (*)  begin
    case(present_state) 
      state_idle       :begin 
                          dir_en=0;
                          sda_out=0;
                          count_en=0;
                          piso_en=0;
                          sipo_en=0;
                           wr_en=0;
                           rd_en=0;
                           stop_en=0;
                      
        start_en=1;
        adress_in=0;
        wr_data=0;
                        end 

       state_start      :begin 
                          dir_en=0;
                          sda_out=0;
                          count_en=0;
                          piso_en=0;
                          sipo_en=0;
                           wr_en=0;
                           rd_en=0;
                          start_en=0;
         adress_in=0;
         wr_data=0;
                        end

      state_reg_addr   :begin
                          dir_en=0;
                          sda_out=0;
                          count_en=1;
                          piso_en=0;
                          sipo_en=1;
                           wr_en=0;
                           rd_en=0;
                          start_en=0;
                         adress_in=0;
        wr_data=0;
                      end
                                           
    state_reg_addr_ack  : //slave will generate ack 
                         begin
                           adress_in=sipo_data;
                           dir_en=1;
                          sda_out=0;
                          count_en=0;
                          piso_en=0;
                          sipo_en=0;
                           wr_en=0;
                           rd_en=0;
                           wr_data=0;
                           
                         end
                    
     state_write  :// write state
                      begin
                          dir_en=0;
                          sda_out=0;
                          count_en=1;
                          piso_en=0;
                          sipo_en=1;
                        wr_en=0;
                        rd_en=0;
                        adress_in=0;
                        wr_data=0;
                        
                      end
             
    state_write_ack : //slave will generate ack 
                        begin
                        dir_en=1;
                          sda_out=0;
                          count_en=0;
                          piso_en=0;
                          sipo_en=0;
                          wr_data=sipo_data;
                          wr_en=1;
                          rd_en=0;
                          adress_in=0;
                         end

    state_read      :// read state
                       begin
                       dir_en=1;
                        sda_out=piso_data[0];
                         count_en=1;
                          piso_en=1;
                          sipo_en=0;
                         wr_en=0;
                         rd_en=(count==0)?1:0;
                         adress_in=0;
                         wr_data=0;
                       end
             
    state_read_ack: //master will generate ack 
                       begin
                        dir_en=0;
                        sda_out=0;
                         count_en=0;
                          piso_en=0;
                          sipo_en=0;
                         wr_en=0;
                           rd_en=0;
                         adress_in=0;
                         wr_data=0;
                       end

    state_stop_m    :begin
                  dir_en=0;
                        sda_out=0;
                         count_en=0;
                          piso_en=0;
                          sipo_en=0;
                         wr_en=0;
                           rd_en=0;
                          stop_en=1;
      adress_in=0;
      wr_data=0;
                   end   
     state_stop   :begin
                  dir_en=0;
                        sda_out=0;
                         count_en=0;
                          piso_en=0;
                          sipo_en=0;
                         wr_en=0;
                           rd_en=0;
                       adress_in=0;
       wr_data=0;
                   end   
      default: begin
                  dir_en=0;
                        sda_out=0;
                         count_en=0;
                          piso_en=0;
                          sipo_en=0;
                         wr_en=0;
                           rd_en=0;
                       adress_in=0;
        wr_data=0;
                   end   
    endcase
    end
    
    // code for SIPO 
    always @ (negedge SCL) begin 
      if (RESET_IN) sipo_data<=0;
      else begin 
        if
          (sipo_en) sipo_data<={SDA,sipo_data[7:1]};
      end
    end
    
    // code for PISO
    always @ (negedge SCL) begin 
       if (RESET_IN) piso_data<=0;
         
      else begin 
        if (piso_en) begin 
          if (count==0) piso_data<=rd_data;
          else piso_data<=piso_data>>1;
        end
      end
     end
   
    

  endmodule