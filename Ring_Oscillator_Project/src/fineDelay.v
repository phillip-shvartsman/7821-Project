module fineDelay(in,select,out);
input wire in;
input wire [2:0] select;

wire [7:0] delays;
wire delay1,delay2,delay3,delay4,delay5,delay6,delay7,delay8;
genvar i;

output reg out;

LCELL delay1LCELL(.in(in),.out(delay1));
LCELL delay2LCELL(.in(delay1),.out(delay2));
LCELL delay3LCELL(.in(delay2),.out(delay3));
LCELL delay4LCELL(.in(delay3),.out(delay4));
LCELL delay5LCELL(.in(delay4),.out(delay5));
LCELL delay6LCELL(.in(delay5),.out(delay6));
LCELL delay7LCELL(.in(delay6),.out(delay7));


always @* begin
	case(select)
		3'b000: out<= in;
		3'b001: out<= delay1;
		3'b010: out<= delay2;
		3'b011: out<= delay3;
		3'b100: out<= delay4;
		3'b101: out<= delay5;
		3'b110: out<= delay6;
		3'b111: out<= delay7;
		default: out<=in;
	endcase
end
endmodule