module clkDivider(input wire in,input wire [1:0] select, output reg out);
 
reg one;
reg[1:0] two;
reg[2:0] three;
reg[3:0] four;

always@(posedge in) begin
	one <= ~one;
	
	two[0] <= ~two[1];
	two[1] <= two[0];
	
	three[0] <= ~three[2];
	three[2:1] <= three[1:0];
	
	four[0] <= ~four[3];
	four[3:1] <= four[2:0];
end
always @* begin
	case(select)
		2'b00: out<=one;
		2'b01: out<=two[0];
		2'b10: out<=three[0];
		2'b11: out<=four[0];
		default: out<=one;
	endcase
end
 
endmodule