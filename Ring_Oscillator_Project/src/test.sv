module test (
input clk,
input [7:0]  din,
output [7:0] dout);

reg [7:0] a,b,c;
wire ring_clk;

always @ (posedge ring_clk)
begin
	a <= din;
	b <= a;
	c <= b;
end
	
assign dout = c;	

ring_osc #(.NUM_LUTS(10))
ring_osc_inst
//(.clk(clk),
(.osc_out(ring_clk));

endmodule



