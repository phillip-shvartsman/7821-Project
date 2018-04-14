module clkDivider(input wire in,input wire [3:0] select, output reg out);
 
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
		4'b0000: out<=one;
		4'b0001: out<=two[0];
		4'b0010: out<=three[0];
		4'b0011: out<=four[0];
		default: out<=one;
	endcase
end
 
endmodule