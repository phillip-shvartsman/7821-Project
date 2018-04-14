module controlModule #(NUM_LUTS = 20,FINECSIZE = 2,FINECBLOCKSIZE=10)(input wire [FINECSIZE-1:0] fcselect,output reg [NUM_LUTS-1:0] control);
integer i,j;
always @* begin
	for(i=0;i<FINECSIZE;i=i+1) begin
		for(j=FINECSIZE*i;j<FINECSIZE*(i+1);j=j+1) begin
			control[j] <= fcselect[i];
		end
	end
end
endmodule