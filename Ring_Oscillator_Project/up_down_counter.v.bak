module up_down_counter #(counterSize = 16)   (
out      ,  
up_in  ,
down_in,  
clkUD      , 
reset       
);
//----------Output Ports--------------
output [counterSize-1:0] out;
//------------Input Ports-------------- 
input up_in, down_in, clkUD, reset;
//------------Internal Variables--------
reg [counterSize-1:0] out;
wire [1:0] updown;
assign updown[1] = up_in;
assign updown[0] = down_in;
//-------------Code Starts Here-------
always @(posedge clkUD) begin
	if (reset) begin // active high reset
		out <= 15'd0 ;
	end
	else begin
		case(updown) 
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
end
endmodule