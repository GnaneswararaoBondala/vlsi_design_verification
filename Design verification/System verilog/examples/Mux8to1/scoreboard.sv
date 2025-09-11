`include "transaction.sv"
class scoreboard;
  transaction tr;
  mailbox mon2scb;

  function new(mailbox mon2scb);
    this.mon2scb = mon2scb;
  endfunction

  function bit expected_out(input [7:0] in, input [2:0] sel);
    case(sel)
      3'b000: expected_out = in[0];
      3'b001: expected_out = in[1];
      3'b010: expected_out = in[2];
      3'b011: expected_out = in[3];
      3'b100: expected_out = in[4];
      3'b101: expected_out = in[5];
      3'b110: expected_out = in[6];
      3'b111: expected_out = in[7];
      default: expected_out = 0;
    endcase
  endfunction

  task run();
    forever begin
      mon2scb.get(tr);
      if (tr.out !== expected_out(tr.in, tr.sel))
        $error("Mismatch: in=%0b sel=%0b expected=%0b got=%0b",
               tr.in, tr.sel, expected_out(tr.in,tr.sel), tr.out);
      else
        $display("Match: in=%0b sel=%0b out=%0b",
                 tr.in, tr.sel, tr.out);
    end
  endtask
endclass
