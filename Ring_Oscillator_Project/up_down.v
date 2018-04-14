module up_down_counter    (
out      ,  
up_in  ,
down_in,  
clk      , 
reset       
);
//----------Output Ports--------------
output [7:0] out;
//------------Input Ports-------------- 
input up_in, down_in, clk, reset;
//------------Internal Variables--------
reg [7:0] out;
//-------------Code Starts Here-------
always @(posedge clk)
if (reset) begin // active high reset
  out <= 8'b0 ;
end else if (up_in & ~down_in) begin
  out <= out + 1;
end else if (down_in & ~up_in) begin
  out <= out - 1;
end

endmodule