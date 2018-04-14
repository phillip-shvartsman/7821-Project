module fineControlModule(
	in,
	fcSelect,
	out
);
genvar genI;
input wire in;
input wire [1:0] fcSelect;
output reg out;

wire outBuff;
LCELL lcell_inst (
		.in  ( in),
		.out ( outBuff )
);



wire [1:0] outAND2;
LCELL lcell_inst0(
	.in(in),
	.out(outAND2[1])
);
LCELL lcell_inst1(
	.in(in),
	.out(outAND2[0])
);


wire [2:0] outAND3;
generate
for(genI=0;genI<3;genI=genI+1) begin : gen3AND
	LCELL lcell_inst(.in(in),.out(outAND3[genI]));
end
endgenerate


wire [3:0] outAND4;

generate
for(genI=0;genI<4;genI=genI+1) begin : gen4AND
	LCELL lcell_inst(.in(in),.out(outAND4[genI]));
end
endgenerate


always @* begin
	case(fcSelect) 
		2'b00: out<= outBuff;
		2'b01: out<= outAND2[1] & outAND2[0];
		2'b10: out<= outAND3[2] & outAND3[1] & outAND3[0];
		2'b11: out<= outAND4[3] & outAND4[2] & outAND4[1] & outAND4[0];
		default: out <= outBuff;
	endcase
end

endmodule