module fork_join_test();
logic clk,a,b;
initial
begin
    clk = 0;
    a = 1;
    b = 1;
    #5; 
    fork
       #5  a = 0;
       #10 b = 0;
    join
    clk = 1; 
end
//clk becomes 1 when //time=20

endmodule


module fork_join_any_test();
logic clk,a,b;
initial
begin
    clk = 0;
    a   = 1;
    b   = 1;
    #5; 
    fork
       #5  a = 0;
       #10 b = 0;
    join_any
    clk = 1; 
end
//clk becomes 1 when //time=10

endmodule

module for_join_none_test();
logic clk,a,b;
initial
begin
    clk = 0;
    a = 1;
    b = 1;
    
    #5; 
    fork
       #5  a = 0;
       #10 b = 0;
    join_none
    clk = 1; 
end
//clk becomes 1 when //time=5


endmodule

