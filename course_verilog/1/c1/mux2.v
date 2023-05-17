module mux2( in1,in2,sel0,out);

input in1, in2,sel0;
output reg out;
 always @(*) begin
 if (sel0)
 out=in1;
 else
 out=in2;
end
endmodule
