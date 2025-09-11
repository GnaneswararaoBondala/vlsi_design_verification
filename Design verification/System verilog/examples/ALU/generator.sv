`include "transaction.sv"  //I am using theese classes that's why included.
`include "interface.sv"
class generator;
  transaction tr;
  mailbox mbx; //mailbox 1
  function new(mailbox mbx);
    this.mbx=mbx;
  endfunction
  task run();
    
      repeat(8) begin
        tr=new();
        assert(tr.randomize()) //Randomizing values
          else $error("Generator randomization failed");
        mbx.put(tr); //Putting in mailbox
          $display("Generator signals sent a=%0d,b=%0d,sel=%0d",tr.a,tr.b,tr.sel);
        
      end
  endtask
endclass
  
        