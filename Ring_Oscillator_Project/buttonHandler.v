module buttonHandler(
	upButton,
	downButton,
	select
);
integer i;
input wire upButton;
input wire downButton;
output reg select[3:0];
reg selectPlus[3:0];
reg selectPlusCarry[3:0];
reg selectMinus[3:0];
reg selectMinusCarry[3:0];
initial begin
	select <= 4'd0;
end
always @* begin
	
end
always @(posedge upButton) begin
	select <= selectPlusCarry;
end
always @(posedge downButton) begin
	select <= selectMinusCarry;
end
endmodule