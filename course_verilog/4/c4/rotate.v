`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/10/2023 01:20:33 PM
// Design Name: 
// Module Name: rotate
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module rotate(input clk,
    input rst,
    input direction,
    output reg [15:0] led
    );
    wire clk_internal,clk_out1,clk_out2;
    clk_dev clk1( clk,rst,clk_internal  );
    
    
    clk_wiz_1 clk2
   (
    // Clock out ports
    .clk_out1(clk_out1),     // output clk_out1
    .clk_out2(clk_out2),     // output clk_out2
    // Status and control signals
    .reset(rst), // input reset
    .locked(locked),       // output locked
   // Clock in ports
    .clk_in1(clk));
always @(posedge clk_out2 or posedge rst) begin
    if(rst) begin
        led <={{15{1'b1}},1'b0};
       
    end else begin
        if (direction) 
            led<={led[0],led[15:1]};
         else
            led<={led[14:0],led[15]};
    end
end
endmodule

module clk_dev(input clk_in, 
input rst,
output reg clk_out  );

parameter DIV_val=1000000*100/32;
reg [$clog2(DIV_val)-1:0] count;

always @(posedge clk_in)begin
if(rst)begin
clk_out<=0;
count<=0;
end
else if(count==DIV_val)
begin
clk_out<=~clk_out;
count<=0;
end
else
count <=count+1;
end 
endmodule 
