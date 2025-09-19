`ifndef TRANSACTION_SV
`define TRANSACTION_SV
class transaction;
    rand logic [7:0] w_data;
    logic enb = 1;
    logic wr;
    logic rd;
    rand logic [4:0] w_addr;
    rand logic [4:0] r_addr;
    logic [7:0] r_data;

    constraint addr_range { w_addr <= 5'd15; r_addr <= 5'd15; }

    function void display(string name);
        $display("-----%s---- %0t", name, $time);
        $display("wr=%0b, rd=%0b, w_addr=%0d, w_data=0x%0h, r_addr=%0d, r_data=0x%0h, enb=%0b",
                 wr, rd, w_addr, w_data, r_addr, r_data, enb);
    endfunction
endclass
`endif