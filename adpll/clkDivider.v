module clkDivider#(MAX_DIV = 8)(input wire in,input wire [2:0] select, output reg out);
genvar i;
reg [MAX_DIV-1:0] clk_out;
always@* begin
	clk_out[0] <= in;
end
//Generate Even
generate for (i=1;i<=MAX_DIV;i=i+1) begin: even_clk_gen
	if(i%2==0)
	begin
		always@(posedge clk_out[(i-i/2)-1]) begin
			clk_out[i-1] <= ~clk_out[i-1];
		end
	end
end
endgenerate

//Divide clk by odd values
generate for (i=3;i<=MAX_DIV;i=i+2) begin: odd_clk_gen
	reg [i-1:0] clk_counter;
	reg ff1;
	reg ff2;
	reg ff1Enable;
	reg ff2Enable;
	always @(posedge in) begin
		case(clk_counter)
			i-1: clk_counter <= 0;
			default: clk_counter <= clk_counter + 1;
		endcase
		case(ff1Enable) 
			1'b1:ff1 <= ~ff1;
			1'b0: ff1 <= ff1;
			default: ff1<= ff1;
		endcase
	end
	always @(negedge in) begin
		case(ff2Enable)
			1'b1:ff2 <= ~ff2;
			1'b0: ff2 <= ff2;
			default: ff2<= ff2;
		endcase
	end
	always@* begin
		clk_out[i-1] = ff1 ^ ff2;
		case(clk_counter) 
			0: begin
				ff1Enable <= 1'b1;
				ff2Enable <= 1'b0;
			end
			(i+1)/2: begin
				ff1Enable <= 1'b0;
				ff2Enable <= 1'b1;
			end
			default: begin
				ff1Enable <= 1'b0;
				ff2Enable <= 1'b0;
			end
		endcase
	end
	end
endgenerate
always @* begin
	out<=clk_out[select];
	/*case(select)
		3'b000: out <=in;
		3'b001: out <=clk_out[1]; //2
		3'b010: out <=clk_out[2]; //3
		3'b011: out <=clk_out[3]; //4
		3'b100: out <= clk_out[4]; //5
		3'b101: out <= clk_out[5]; //6
		3'b110: out <= clk_out[6]; //7
		3'b111: out <= clk_out[7]; //8
		default: out<=in;
	endcase*/
end
 
endmodule