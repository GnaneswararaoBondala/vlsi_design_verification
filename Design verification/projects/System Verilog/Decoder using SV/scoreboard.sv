`include "transaction.sv"
`include "interface.sv"
class scoreboard;
  mailbox mon2scb;
  
  function new(mailbox mon2scb);
    this.mon2scb=mon2scb;
  endfunction
  
  function [7:0]expected_out(input [2:0]in);
    case(in)
      3'b000:expected_out=8'b0000_0001;
      3'b001:expected_out=8'b0000_0010;
      3'b010:expected_out=8'b0000_0100;
      3'b011:expected_out=8'b0000_1000;
      3'b100:expected_out=8'b0001_0000;
      3'b101:expected_out=8'b0010_0000;
      3'b110:expected_out=8'b0100_0000;
      3'b111:expected_out=8'b1000_0000;
      default:expected_out=3'bxxx;
    endcase
  endfunction
  
  task run();
    forever begin
      transaction tr;
      mon2scb.get(tr);
      if(tr.out	!=expected_out(tr.in))
        $error("Mismatch occurred in=%0b,out=%0b",tr.in,tr.out);
      else
        $display("Match occurred in=%0b and out=%0b",tr.in,tr.out);
    end
  endtask
endclass
      