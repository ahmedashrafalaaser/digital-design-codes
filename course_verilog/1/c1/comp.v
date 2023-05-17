module com(a,b,out);
parameter w=3;
input [w-1:0]a;
input [w-1:0]b ;
output reg [2:0]out;
always @(*) begin
	if(a==3'bx)
	out= 3'b_010;
	else if(a>b)
	out=3'b001;
	else if(a<b)
	out=3'b100;
	else
	out=3'b000 ;

end


endmodule