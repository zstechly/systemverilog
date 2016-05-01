interface pkt_interface( input bit clk);
                         logic [31:0]   hdr_in;
                         logic          sop_in;
                         logic          ena_in;
                         logic [31:00]  data0_in;
                         logic          ena_out;
                         logic          sop_out;
                         logic [31:00]  data0_out;
endinterface


module base_interface_device(pkt_interface filter_sig);
  always @(posedge filter_sig.clk) begin
      if (filter_sig.ena_in) begin
         filter_sig.data0_out       <= 32'h10101010;
      end
  end
endmodule 


module basic_interface_driver(pkt_interface test_sig);
   always @(posedge test_sig.clk) begin
      test_sig.ena_in    <= 1;
   end
endmodule

// simulate me
module basic_interface_tester();
  logic clk;
  pkt_interface ourInterface(clk);
  
  initial begin
     clk = 0;
     // send our clock off
     forever #50 clk = ~clk;
     $display("ending initial block");
  end
  
  base_interface_device our_device(
     .filter_sig    ( ourInterface)
  );
  
  
  basic_interface_driver out_driver(
     .test_sig      (  ourInterface)
  );
  
  
endmodule

