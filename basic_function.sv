module basic_function();

// return example
function bit negate(bit a);
   return ~a;
endfunction

bit func_in, func_out;

initial begin
  func_in = 0;
  func_out = negate(func_in);
  
  $display(func_in);
  $display(func_out);

end


endmodule
