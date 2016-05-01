class Packet;
   rand bit [31:0] src, dst, data[8]; // packed array in Data there
   constraint c {src > 10; src < 15;}
endclass

module basic_randomization_test();
    Packet p;
    initial begin
    p = new();
    p.randomize();
    end
endmodule