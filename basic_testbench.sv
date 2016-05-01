interface pkt_interface( input bit clk);
                         int          timestamp;
                         logic           sop_in;
                         logic           ena_in;
                         int           data0_in;
                         int           data1_in;
                         logic          ena_out;
                         logic          sop_out;
                         int          data0_out;
                         int          data1_out;
endinterface

class Packet;
   randc int timestamp; 
   rand int data0[8], data1[8];
   constraint c {timestamp > 0; timestamp < 1435;}
endclass

class Generator;
   mailbox gen2drv;
   Packet pkt;
   
   function new (input mailbox gen2drv);
     this.gen2drv = gen2drv;
   endfunction
   
   task run();
     $display("inside generator run");
     //forever begin
     for (int x = 0; x < 10; x++) begin
        pkt = new();
        assert(pkt.randomize());
        gen2drv.put(pkt);
     end // end loop
     //end
    endtask
endclass

class Driver;
 mailbox gen2drv;
 virtual pkt_interface pkt_intf;
 function new (input mailbox gen2drv, virtual pkt_interface intf);
   this.gen2drv = gen2drv;
   pkt_intf = intf;
 endfunction
 
 task main;
   Packet pkt;
   $display("inside driver main");
   for (int x = 0; x < 10; x++) begin
     gen2drv.get(pkt);
     @(posedge(pkt_intf.clk));
       pkt_intf.sop_in = 1;
       pkt_intf.ena_in = 1;
       pkt_intf.data0_in = pkt.data0[0];
       pkt_intf.data1_in = pkt.data1[0];
       pkt_intf.timestamp = pkt.timestamp;
     @(posedge(pkt_intf.clk));
       pkt_intf.sop_in = 0;
       pkt_intf.ena_in = 1;
       pkt_intf.data0_in = pkt.data0[1];
       pkt_intf.data1_in = pkt.data1[1];
       pkt_intf.timestamp = pkt.timestamp;
     @(posedge(pkt_intf.clk));
       pkt_intf.sop_in = 0;
       pkt_intf.ena_in = 1;
       pkt_intf.data0_in = pkt.data0[2];
       pkt_intf.data1_in = pkt.data1[2];  
       pkt_intf.timestamp = pkt.timestamp;   
     @(posedge(pkt_intf.clk));
       pkt_intf.sop_in = 0;
       pkt_intf.ena_in = 1;
       pkt_intf.data0_in = pkt.data0[3];
       pkt_intf.data1_in = pkt.data1[3];  
       pkt_intf.timestamp = pkt.timestamp;   
     @(posedge(pkt_intf.clk));
       pkt_intf.sop_in = 0;
       pkt_intf.ena_in = 1;
       pkt_intf.data0_in = pkt.data0[4];
       pkt_intf.data1_in = pkt.data1[4];  
       pkt_intf.timestamp = pkt.timestamp;   
     @(posedge(pkt_intf.clk));
       pkt_intf.sop_in = 0;             
       pkt_intf.ena_in = 0;             
       pkt_intf.data0_in = 0;
       pkt_intf.data1_in = 0;
       pkt_intf.timestamp = pkt.timestamp;
     @(posedge(pkt_intf.clk));
     @(posedge(pkt_intf.clk));
     @(posedge(pkt_intf.clk));  
    end
   endtask
 endclass
 
 program basic_randomization_test(pkt_interface intf);
    Generator gen;
    Driver drv;
    mailbox gen2drv;
    
    initial begin
       gen2drv = new();
       gen = new(gen2drv);
       drv = new(gen2drv, intf);
       //fork
       gen.run();
       drv.main();
       //join_none
    end
endprogram

//advanced chip flips data
module DUT(pkt_interface intf);
   always@(posedge intf.clk) begin
       intf.sop_out   <= intf.sop_in;
       intf.ena_out   <= intf.ena_in;
       intf.data0_out <= intf.data1_in;
       intf.data1_out <= intf.data0_in;
   end
endmodule

module basic_testbench_top();
  logic clk;
  initial begin
     clk = 0;
  end
  
  always #1000 clk =~clk;
  
  pkt_interface ourInterface(clk);
  DUT ourDUT(.intf    (ourInterface));
  basic_randomization_test ourTest(.intf (ourInterface));
endmodule