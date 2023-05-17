`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.05.2023 13:19:53
// Design Name: 
// Module Name: NonRestoring_div
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


module NonRestoring_div #(parameter WIDTH=4)(
    input[WIDTH-1:0] Divisor,Dividend,
    input sgn,
    output[WIDTH-1:0] R,Q
    );
    
    wire[WIDTH+1:0] Aout[WIDTH+1:0], Bs, Rem;
    wire[WIDTH:0] Qout[WIDTH+1:0];
    wire Qs;
    assign Bs=(sgn)?{{2{Divisor[WIDTH-1]}},Divisor}:Divisor;
    assign Qs=sgn&(Dividend[WIDTH-1]);
    assign Aout[0]={(WIDTH+2){1'b0}}, Qout[0]={Qs,Dividend};
    
    generate
    genvar i;
    for(i=0;i<=WIDTH;i=i+1) begin
        
        Div_stage #(4) Div(
            .Ain(Aout[i]),
            .B(Bs),
            .Qin(Qout[i]),
            .Aout(Aout[i+1]),
            .Qout(Qout[i+1])
        );
       
    end
    endgenerate
    
    assign Rem=Aout[WIDTH+1];
    assign Q=Qout[WIDTH+1],R=(Rem[WIDTH+1])?(Rem+Bs):Rem;
    
endmodule

module Div_stage #(parameter WIDTH=4)(
    input[WIDTH+1:0] Ain,B,
    input[WIDTH:0] Qin,
    output[WIDTH+1:0] Aout,
    output[WIDTH:0] Qout
);
    
    wire[WIDTH+1:0] Asum,Asub,Ain1,Atemp;
    wire Ql=~Aout[WIDTH+1];
    assign Ain1={Ain[WIDTH:0],Qin[WIDTH]};
    assign Asum=Ain1+B, Asub=Ain1+(~B+1), Aout=(Ain1[WIDTH+1])?Asub:Asum;
    assign Qout={Qin,Ql};       
            
endmodule