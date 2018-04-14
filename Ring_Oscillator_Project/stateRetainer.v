module stateRetainer(in,out);
	input wire in;
	output reg out;
	reg [2:0] outReg;
	always @* begin
		outReg[2] <= ~in;
		
	end
endmodule