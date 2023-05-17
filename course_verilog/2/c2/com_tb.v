module com_tb();
parameter W=1;
reg [W-1:0]a;
reg [W-1:0]b ;
wire [2:0]out;
integer i;

	
com #(W) a(a,b,out);
initial begin
	for(i=0;i<10;i=i+1)begin
	W=$random;
	a=$random;
	b=$random;
	#10
	end
	$stop;
end
initial begin
$monitor("a=%d,b=%d,out=%b",a,b,out);
end

endmodule