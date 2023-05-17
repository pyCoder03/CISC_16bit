`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.03.2023 23:53:42
// Design Name: 
// Module Name: CISC_16bit
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


module CISC_16bit(AD_Bus,clk);

inout wire AD_Bus;
input clk;

//T-state counter
reg fetch;
reg[1:0] t_state=0;
reg[5:0][8:0] queue;        //Queue rows and flags
reg[5:0][7:0] update;
reg[2:0] shift;
  
always @(posedge clk) begin
t_state=t_state+1;
end

//Prefetch Queue(6byte)
genvar i;
generate
for(i=0;i<6;i=i+1) begin:row
    D_8bit row(queue[i],clk,update[i]);
    D_FF fl(q,clk,d);
end
endgenerate
endmodule

always @(*) begin
    case queue[

module D_FF(q,clk,d);
input clk,d;
output reg q;
always @(posedge clk) begin
q=d;
end
endmodule

module D_8bit(q,clk,d);
input[7:0] d;
input clk;
output reg[7:0] q;
always @(posedge clk) begin
q=d;
end
endmodule

module mux_8bit(out,sel,in0,in1,in2,in3,in4,in5,in6,in7);
input[7:0] in0,in1,in2,in3,in4,in5,in6,in7;
output[7:0] out;
input[2:0] sel;
case(sel)
    3'b000: out=in0;
    3'b001: out=in1;
    3'b010: out=in2;
    3'b011: out=in3;
    3'b100: out=in4;
    3'b101: out=in5;
    3'b110: out=in6;
    3'b111: out=in7;
 endcase
 endmodule
 
 module