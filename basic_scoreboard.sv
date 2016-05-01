module  basic_scoreboard();

// create queue of values
initial begin

// create random array..with intentional error
int data[] = '{1,3,2,5,7,6,8,11,7,9,4,10,12,14,13};

// check our data
// create a queue of results
int results[$];

// imagine I put this in a function
for (int x = 0; x < 14; x++) begin
  results = data.find_index() with (item == x);
  case(results.size())
  0: $display("Value %h not found",x);
  1: $display("Value %h found exactly once",x);
  default: $display("COLLISION AT VALUE OF %h",x);
  endcase
end // end loop

end

endmodule