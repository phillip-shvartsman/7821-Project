module phase_1(
	input ref,
	input data,
	output up,
	output down );
	
	wire ref_int;
	(* preserve *)reg reset;
	reg up_int;
	reg down_int;
	wire [1:0] lut_wire;
	wire temp_1, temp_2, temp_3, temp_4;
	wire temp_reset, temp_reset_out;
	
	//alt_inbuf inst_inbuf(.i(ref), .o(ref_int));
	assign ref_int = ref;
	//alt_inbuf inst_inbuf(i.(ref), o.(ref_int));
	//alt_outbuf inst_outbuf_up(.i(up_int), .o(up));
	//alt_outbuf inst_outbuf_down(.i(down_int), .o(down));
	
	assign up = up_int;
	assign down = down_int;
//	dff dff_up(.d(data), .q(up_int), .clk(ref_int), .clrn(reset));
//	dff dff_down(.d(data), .q(down_int), .clk(ref_int), .clrn(reset));

	assign temp_1 = 1'b1;
	assign temp_2 = 1'b1;
	assign temp_reset = ~(up_int & down_int);
	


	
//	always@(up_int, down_int)
//	begin
//		reset <= ~(up_int & down_int);
//	end
	
	
	
	generate
	begin : nand_cell
	LCELL lcell_inst_nand (
		.in  ( temp_reset ),
		.out ( temp_reset_out )
	);
	end
	endgenerate
	
		generate
	begin : up_flop
	LCELL lcell_inst_up (
		.in  ( temp_1 ),
		.out ( temp_3 )
	);
	end
	endgenerate
	
	generate
	begin : down_flop
	LCELL lcell_inst_down (
		.in  ( temp_2 ),
		.out ( temp_4 )
	);
	end
	endgenerate
	
	always@(posedge ref_int, negedge temp_reset_out)
	begin
		if(~temp_reset_out)
			up_int <= 1'b0;
		else
			up_int <= temp_3;
	end
	
	always@(posedge data, negedge temp_reset_out)
	begin
		if(~temp_reset_out)
			down_int <= 1'b0;
		else
			down_int <= temp_4;
	end
	

	
	
	
	
	
	
endmodule
