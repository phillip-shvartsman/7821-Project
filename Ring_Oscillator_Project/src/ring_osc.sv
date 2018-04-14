module ring_osc #(NUM_LUTS = 20)(
	input wire [NUM_LUTS-1:0] controlIn,
	output reg osc_out
);

wire [NUM_LUTS-1:0] lut_wire;
wire [NUM_LUTS-1:0] controlOut;


wire [NUM_LUTS-1:0] lut_wire_in;

(* preserve *) wire static_clk;

(* preserve *) reg constant; //rts

genvar i;


generate for (i=0;i<NUM_LUTS-1;i++) // Only do NUM_LUTs-1 instances, as another LUT will be added to do the XOR
begin : lut_ring
	
	delayModule delayMod(.in(lut_wire[i]),.out(lut_wire[i+1]),.control(controlIn[i]));
	
end
endgenerate



always_ff @ (posedge static_clk)
	constant <= 1'b0;

assign lut_wire[0] = (lut_wire[NUM_LUTS-1] ^ !constant)  ;


assign osc_out = lut_wire[0];


endmodule
