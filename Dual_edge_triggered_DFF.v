`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.04.2023 09:43:43
// Design Name: 
// Module Name: Dual_edge_triggered_DFF
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

//"DFF_POSEDGE":["NAND 7 5 4","NAND 4 1 3 5","NAND 5 1 7 6","NAND 6 2 3 7","NAND 5 9 8","NAND 8 6 3 9",{"CLK":"1","D":"2","RST":"3","Q":"8","Q'":"9"}], #Reset is active low
module nand3(a,b,c);
output a;
input b,c;
assign a=~(b&c);
endmodule

module nand3(a,b,c,d);
output a;
input b,c,d;
assign a=~(b&c&d);
endmodule

module DFF_posedge(q,d,clk,rst);
output q;
input d,clk,rst;
wire w4,w5,w6,w7,q1;
nand2(w4,w7,w5);
nand3(w5,w4,clk,rst);
nand3(w6,w5,clk,w7);
nand3(w7,w6,d,rst);
nand2(q,q1,w5);
nand3(q1,q,w6,rst);
endmodule 

module DFF_negedge(q,d,clk,rst);
output q;
input d,clk,rst;
wire c1;
not(c1,clk);
DFF_posedge DH(
    .q(q),
    .d(d1),
    .clk(clk),
    .rst(rst)
    );
endmodule

module Dual_edge_triggered_DFF(q,d,clk,rst);
output q;
input d,clk,rst;
wire q1,q0,d1,d0;
xor(d1,q0,d);
xor(d0,q1,d);
xor(q1,q0,q);
DFF_posedge DH(
    .q(q1),
    .d(d1),
    .clk(clk),
    .rst(rst)
    );
DFF_negedge DL(
    .q(q0),
    .d(d0),
    .clk(clk),
    .rst(rst)
    );
endmodule

module TFF_negedge(q,t,clk,rst);
output q;
input t,clk,rst;
wire d;
xor(d,q,t);
DFF_negedge DH(
    .q(q),
    .d(d),
    .clk(clk),
    .rst(rst)
    );
endmodule
