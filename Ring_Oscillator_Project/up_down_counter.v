module up_down_counter #(counterSize = 16)   (
out      ,  
up_in  ,
down_in,  
clkUD      , 
reset    ,
divSelect,
fineSelect
);
//----------Output Ports--------------
output reg [counterSize-1:0] out;
output reg [1:0] divSelect;
output reg [2:0] fineSelect;
//------------Input Ports-------------- 
input up_in, down_in, clkUD, reset;
//------------Internal Variables--------
wire [1:0] updown;
assign updown[1] = up_in;
assign updown[0] = down_in;
reg [5:0] countUp;
reg [5:0] countDown;
//-------------Code Starts Here-------
always @(posedge clkUD) begin
	if (reset) begin // active high reset
		out <= {(counterSize-1){1'b1}} ;
	end
	else begin
		case(updown) 
			2'b00:out<=out;
			2'b11:out<=out;
			2'b01:begin
				out[counterSize-1] <= 1'b0;
				out[counterSize-2:0]<=out[counterSize-1:1];
				countDown <= countDown + 1;
			end
			2'b10:begin
				out[0] <= 1'b1;
				out[counterSize-1:1]<=out[counterSize-2:0];
				countUp <= countUp + 1;
			end
			default:out<=out;
		endcase
	end
	case({out[counterSize-1],out[0]})
		2'b11: begin
			divSelect <= divSelect - 1;
		end
		2'b00: begin 
			divSelect <= divSelect + 1;
		end
		default: divSelect <= divSelect;
	endcase
	case({countUp,countDown})
		12'b0000_0011_1111: 
			case(fineSelect)
				3'b111: fineSelect <= fineSelect;
				default:fineSelect <= fineSelect + 1;
			endcase
		12'b1111_1100_0000: 
			case(fineSelect)
				3'b000: fineSelect <= fineSelect;
				default:fineSelect <= fineSelect - 1;
			endcase
		default: fineSelect <= fineSelect;
	endcase
end

endmodule