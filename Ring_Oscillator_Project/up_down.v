module up_down_counter    (
out      ,  
up_in  ,
down_in,  
clk      , 
reset       
);
//----------Output Ports--------------
output [15:0] out;
//------------Input Ports-------------- 
input up_in, down_in, clk, reset;
//------------Internal Variables--------
reg [15:0] out;
wire [1:0] updown;
assign updown[1] = up_in;
assign updown[0] = down_in;
//-------------Code Starts Here-------
always @(posedge clk) begin
	if (reset) begin // active high reset
		out <= 15'd0 ;
	end
	else begin
		case(updown) 
			2'b00:out<=out;
			2'b11:out<=out;
			2'b01:out<=out-1;
			2'b10:out<=out+1;
			default:out<=out;
		endcase
	end
end
endmodule