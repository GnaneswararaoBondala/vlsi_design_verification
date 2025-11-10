`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
class environment;
    generator gen;
    driver drv;
    monitor mon;
    scoreboard scb;

    mailbox mbx = new();
    mailbox mon2scb = new();
    virtual intf vif;

    function new(virtual intf vif);
        this.vif = vif;
        gen = new(mbx);
        drv = new(mbx, vif);
        mon = new(mon2scb, vif);
        scb = new(mon2scb);
    endfunction

    task run();
        fork
            drv.run();
            mon.run();
            scb.run();
            begin
                gen.write(); #20;
                gen.write(); #20;
                gen.write_then_read(); #20;
                gen.read(); #20;
            end
        join_none
    endtask
endclass
