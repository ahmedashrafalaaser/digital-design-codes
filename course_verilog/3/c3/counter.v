module caunter(clk,rst,en_load,up_down,load,cnt);
parameter N=0;
input clk,rst,en_load;
input [1:0]up_down;
input [N-1:0]load;
output [N-1:0] cnt;
always @(posedge clk ) begin
	if (rst) begin
		// reset
		cnt=0;
		
	end
	else if (en_load) begin
		cnt<=load;
	end
	else if (up_down)  begin
		cnt=cnt+1;
	end
	else   begin
		cnt=cnt-1;
	end
end

endmodule

module caunter_tb();
parameter N;
reg clk,rst,en_load;
reg [1:0] up_down;
reg [N-1] load;
wire cnt;


integer i=0;
 
initial begin
	clk=0;
	forever
	#8 clk=~clk;
end
endmodule