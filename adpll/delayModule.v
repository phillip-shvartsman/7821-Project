module delayModule(input wire in,output reg out,input wire control);
	wire delayedOne1;
	wire delayedTwo1;
	wire delayedTwo2;
	LCELL lcell_inst1(.in(in),.out(delayedOne1));
	LCELL lcell_inst2(.in(in),.out(delayedTwo1));
	LCELL lcell_inst3(.in(delayedTwo1),.out(delayedTwo2));
	always @* begin
		case(control)
			1'b1: out <= delayedOne1;
			1'b0: out <= delayedTwo2;
		endcase
	end
endmodule