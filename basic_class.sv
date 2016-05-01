class Pkt;
    logic [31:00] hdr;
    logic [31:00] data0;
    logic [31:00] data1;
    int          length;
    int      hdr_length;

function new(int len=31,hdr_len=16);
    length    = len;
    hdr_length = hdr_len;
    data0     = 0;
    data1     = 0;
endfunction

function set_data(logic [31:00] data_0,data_1);
    data0      = data_0;
    data1      = data_1;
endfunction

function print_data();
    $display("length: %d header length: %d data0: %d data1: %d",length,hdr_length,data0,data1);
endfunction

endclass


module basic_class_test();

  Pkt packet;
  
  initial begin
     packet = new(24,16);  // create new packet with length 24, hdr length 16
     packet.set_data(32'd15,32'd18);
     packet.print_data();
  end

endmodule