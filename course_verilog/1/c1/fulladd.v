module fulladd(i,x,cin,out,cout);
input [3:0] i;
input [3:0] x;
input cin;
output reg [3:0] out;
output reg cout;
always @(*)begin
	{cout,out}=i+x+cin;
end


endmodule	