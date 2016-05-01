module automatic function_ref();

//// function example passing an array...via reference
function void change_array(ref int a[]);
  foreach(a[i])
   a[i] = i*2;
endfunction


int my_array[];

initial begin

  my_array = new[10];

// initialize array
 foreach(my_array[i])
   my_array[i] = i;

$display("Display initial array results");
 foreach(my_array[i])
   $display(my_array[i]);

// call function on array
change_array(my_array);

// now print this out again
$display("Display post function array results");
 foreach(my_array[i])
   $display(my_array[i]);

end
endmodule