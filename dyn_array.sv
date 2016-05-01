module dyn_array();
int dynamic_array[];

initial begin
  dynamic_array = new[100];
  dynamic_array[5] = 96;
  $display(dynamic_array[5]);
  $display(dynamic_array[4]);
  $display(dynamic_array.size());
  dynamic_array.delete();
end

endmodule