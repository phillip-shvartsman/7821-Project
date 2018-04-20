module clkDivider(input wire in,input wire [1:0] select, output reg out);
 
reg n2;
reg n4;
reg n8;

always@(posedge in) begin
	 n2 <= ~n2;
end
always@(posedge n2) begin
	n4 <= ~n4;
end
always@(posedge n4) begin
	n8 <= ~n8;
end
always @* begin
	case(select)
		2'b00: out<=in;
		2'b01: out<=n2;
		2'b10: out<=n4;
		2'b11: out<=n8;
		default: out<=in;
	endcase
end
 
endmodule