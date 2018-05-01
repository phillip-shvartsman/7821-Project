module controlModule #(NUM_LUTS = 20,NUM_CONT = 2,NUM_IN_CONTROL_BLOCK=10)(input wire [NUM_CONT-1:0] lf_out,output reg [NUM_LUTS-1:0] control);
//Assign NUM_IN_CONTROL_BLOCK number of delay modules to each NUM_CONT number of control signals
integer i,j;
always @* begin
	//For each control signal
	for(i=0;i<NUM_CONT;i=i+1) begin 
		 //Assign NUM_IN_CONTROL_BLOCK delay modules to each control signal
		for(j=NUM_IN_CONTROL_BLOCK*i;j<NUM_IN_CONTROL_BLOCK*(i+1);j=j+1) begin
			control[j] <= lf_out[i];
		end
	end
end
endmodule