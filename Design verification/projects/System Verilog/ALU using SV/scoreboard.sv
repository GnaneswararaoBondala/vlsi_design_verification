`include "transaction.sv"
`include "interface.sv"
class scoreboard;
  mailbox mon2scb;
  transaction tr;
  reg [8:0]exp;//taken due to multiple inputs.if single input directly compare.
 
  
  function new(mailbox mon2scb);
    this.mon2scb=mon2scb;
  endfunction
  
  function [4:0]expected_out(input [2:0]a,b,sel);
    case(sel)
      3'b000:expected_out=a+b;
      3'b001:expected_out=a-b;
      3'b010:expected_out=a&b;
      3'b011:expected_out=a^b;
      3'b100:expected_out=a|b;
      3'b101:expected_out=~(a&b);
      3'b110:expected_out=~(a|b);
      3'b111:expected_out=a%b;
      default:expected_out='bx;
    endcase
  endfunction
  
  task run();
    forever begin
      tr=new();
      mon2scb.get(tr);//getting from mailbox
      
      exp=expected_out(tr.a,tr.b,tr.sel);//passing args
      if(tr.out!=exp)//checking
        $error("mismatch occurred signals are a=%0b,b=%0b,sel=%0b,out=%0b",tr.a,tr.b,tr.sel,tr.out);
      else begin
        $display("Match occurred scoreboard signals a=%0b,b=%0b,sel=%0b and out=%b",tr.a,tr.b,tr.sel,tr.out);
      end
    end
  endtask
endclass
      