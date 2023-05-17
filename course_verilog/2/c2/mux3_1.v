module mux3(D0,D1,D2,S0,S1,Out);
parameter W=1;
input [W-1:0] D0,D1,D2;
input S0,S1;
output   [W-1:0]Out;

assign Out =(S1==0)? ((S0==0)? D0:D1):D2 ;

endmodule
/*module mux3_df(D0,D1,D2,S0,S1,Out);

input D0,D1,D2,S0,S1;
output reg Out;

always @(*) begin
	if (!S1&&!S0)
	Out=D0;
	else if(!S1&&S0)
	Out=D1
	else
	Out=D2	
end

 endmodule



/*module mux3_tb();

mux3 m1(D0,D1,D2,S0,S1,Out);




endmodule*/
