module logic_example(
  input    wire              clk,
  input    logic [15:00]   bus_in,
  input    logic           ena_in,
  output   logic [15:00]  bus_out,
  output    logic          ena_out
);

logic [15:00] logic_rotate;

always @(posedge clk) begin
  logic_rotate    <= {bus_in[0],bus_in[15:01]};
  ena_out         <= ena_in;
  end
  
assign bus_out  = logic_rotate;

endmodule