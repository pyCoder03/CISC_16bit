`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.05.2023 20:24:51
// Design Name: 
// Module Name: Booth_mult
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


module Booth_mult #(parameter WIDTH=4)(
    input[WIDTH-1:0] Q,M,
    input sgn,                  //To branch whether the number is signed or not
    output[2*WIDTH-1:0] Z 
    );
    
//    wire[3:0] Aout1,Aout2,Aout3,Aout4;
//    wire[4:0] Qout1,Qout2,Qout3,Qout4;
    
    wire[WIDTH:0] Aout[WIDTH+1:0],Ms;
    wire[WIDTH+1:0] Qout[WIDTH+1:0];
    wire Qh=(sgn==1)?Q[WIDTH-1]:1'b0,Mh=(sgn==1)?M[WIDTH-1]:1'b0;
    assign Aout[0]={(WIDTH+1){1'b0}}, Qout[0]={Qh,Q,1'b0}, Ms={Mh,M};
    
    generate
    genvar i;
    for(i=0;i<=WIDTH;i=i+1) begin
        
        Booth_stage #(WIDTH) booth(
            .Ain(Aout[i]),
            .M(Ms),
            .Qin(Qout[i]),
            .Aout(Aout[i+1]),
            .Qout(Qout[i+1])
        );
        
    end
    endgenerate
    
//    Booth_stage booth1(
//        .Ain(4'b0000),
//        .M(M),
//        .Qin({Q,1'b0}),
//        .Aout(Aout1),
//        .Qout(Qout1)
//    );
    
//    Booth_stage booth2(
//        .Ain(Aout1),
//        .M(M),
//        .Qin(Qout1),
//        .Aout(Aout2),
//        .Qout(Qout2)
//    );
    
//    Booth_stage booth3(
//        .Ain(Aout2),
//        .M(M),
//        .Qin(Qout2),
//        .Aout(Aout3),
//        .Qout(Qout3)
//    );
    
//    Booth_stage booth4(
//        .Ain(Aout3),
//        .M(M),
//        .Qin(Qout3),
//        .Aout(Aout4),
//        .Qout(Qout4)
//    );
    
    assign Z={Aout[WIDTH+1],Qout[WIDTH+1][WIDTH+1:1]};
endmodule

module Booth_stage #(parameter WIDTH=4)(
    input[WIDTH:0] Ain,M,
    input[WIDTH+1:0] Qin,
    output[WIDTH:0] Aout,
    output[WIDTH+1:0] Qout
);
    wire[WIDTH:0] Asum,Asub;
    reg[WIDTH:0] Atemp;
    reg[WIDTH+1:0] Qtemp;
    assign Asum=Ain+M,Asub=Ain+(~M+1);
    always @(*) begin
        case(Qin[1:0])
            2'b00, 2'b11: begin
                Atemp={Ain[WIDTH],Ain[WIDTH:1]};
                Qtemp={Ain[0],Qin[WIDTH+1:1]};
            end
            2'b01: begin
                Atemp={Asum[WIDTH],Asum[WIDTH:1]};
                Qtemp={Asum[0],Qin[WIDTH+1:1]};
            end
            2'b10: begin
                Atemp={Asub[WIDTH],Asub[WIDTH:1]};
                Qtemp={Asub[0],Qin[WIDTH+1:1]};
            end
        endcase
    end
    assign Aout=Atemp;
    assign Qout=Qtemp;
endmodule

