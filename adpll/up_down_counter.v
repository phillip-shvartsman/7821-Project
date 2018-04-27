module up_down_counter #(counterSize = 16)   (
out,  
up_in,
down_in,  
clkUD, 
reset,
divSelect
);
//----------Output Ports--------------
//Output to Frequency Control
output reg [counterSize-1:0] out; 
//Output to Divider
output reg [1:0] divSelect;
//------------Input Ports-------------- 
input up_in, down_in, clkUD, reset;
//-------------Code Starts Here-------
always @(posedge clkUD) begin
	if (reset) begin // active high reset
		out <= {(counterSize-1){1'b1}} ;
	end
	else begin
		//Shift in zeros or ones into the ouput signal based on up and down signal
		case({up_in,down_in}) 
			2'b00:out<=out;
			2'b11:out<=out;
			2'b01:begin
				out[counterSize-1] <= 1'b0;
				out[counterSize-2:0]<=out[counterSize-1:1];
			end
			2'b10:begin
				out[0] <= 1'b1;
				out[counterSize-1:1]<=out[counterSize-2:0];
			end
			default:out<=out;
		endcase
	end
	//Choose a clk divider to ensure lock
	//If the output is all zeros or all ones, inc/dec divider
	case({out[counterSize-1],out[0]})
		2'b11: begin
			divSelect <= divSelect - 1;
		end
		2'b00: begin 
			divSelect <= divSelect + 1;
		end
		default: divSelect <= divSelect;
	endcase
end

endmodule