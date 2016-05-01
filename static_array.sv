module static_array();


int static_array[10][20];

initial begin

  foreach(static_array[i,k])
     static_array[i][k] = i*k;
  foreach(static_array[i,k])
     $display(static_array[i][k]);

end

endmodule