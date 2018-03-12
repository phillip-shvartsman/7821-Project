module ring_osc #(NUM_LUTS = 20) (
	static_clk,
	select3,
	select2,
	select1,
	select0,
	osc_out
);
input static_clk;
input select3;
input select2;
input select1;
input select0;
output osc_out;

reg [3:0] select;

reg muxOut;
wire [NUM_LUTS-1:0] lut_wire;
wire xor_lut;
(* preserve *) wire static_clk;

(* preserve *) reg constant; //rts

genvar i;
generate for (i=0;i<NUM_LUTS-1;i++) // Only do NUM_LUTs-1 instances, as another LUT will be added to do the XOR
begin : lut_ring

	LCELL lcell_inst (
		.in  ( lut_wire[i] ),
		.out ( lut_wire[i+1] )
);

end
endgenerate

always_ff @ (posedge static_clk)
	constant <= 1'b0;

assign lut_wire[0] = muxOut ^ !constant;


assign osc_out = lut_wire[0];

always @* begin
	select <= {select3,select2,select1,select0};
	case(select)
		4'b0000: muxOut <= lut_wire[98];
		4'b0001: muxOut <= lut_wire[94];
		4'b0010: muxOut <= lut_wire[90];
		4'b0011: muxOut <= lut_wire[86];
		4'b0100: muxOut <= lut_wire[82];
		4'b0101: muxOut <= lut_wire[78];
		4'b0110: muxOut <= lut_wire[74];
		4'b0111: muxOut <= lut_wire[70];
		4'b1000: muxOut <= lut_wire[66];
		4'b1001: muxOut <= lut_wire[62];
		4'b1010: muxOut <= lut_wire[58];
		4'b1011: muxOut <= lut_wire[54];
		4'b1100: muxOut <= lut_wire[50];
		4'b1101: muxOut <= lut_wire[46];
		4'b1110: muxOut <= lut_wire[42];
		4'b1111: muxOut <= lut_wire[40];
		default: muxOut <= lut_wire[98];
	endcase
end
endmodule
