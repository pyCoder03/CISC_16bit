`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.05.2023 09:01:18
// Design Name: 
// Module Name: Booth_4bit
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
    output[2*WIDTH-1:0] Z 
    );
    
//    wire[3:0] Aout1,Aout2,Aout3,Aout4;
//    wire[4:0] Qout1,Qout2,Qout3,Qout4;
    
    wire[WIDTH-1:0] Aout[WIDTH:0];
    wire[WIDTH:0] Qout[WIDTH:0];
    assign Aout[0]={WIDTH{1'b0}}, Qout[0]={Q,1'b0};
    
    generate
    genvar i;
    for(i=0;i<WIDTH;i=i+1) begin
        
        Booth_stage #(WIDTH) booth(
            .Ain(Aout[i]),
            .M(M),
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
    
    assign Z={Aout[WIDTH],Qout[WIDTH][WIDTH:1]};
endmodule

module Booth_stage #(parameter WIDTH=4)(
    input[WIDTH-1:0] Ain,M,
    input[WIDTH:0] Qin,
    output[WIDTH-1:0] Aout,
    output[WIDTH:0] Qout
);
    wire[WIDTH-1:0] Asum,Asub;
    reg[WIDTH-1:0] Atemp;
    reg[WIDTH:0] Qtemp;
    assign Asum=Ain+M,Asub=Ain+(~M+1);
    always @(*) begin
        case(Qin[1:0])
            2'b00, 2'b11: begin
                Atemp={Ain[WIDTH-1],Ain[WIDTH-1:1]};
                Qtemp={Ain[0],Qin[WIDTH:1]};
            end
            2'b01: begin
                Atemp={Asum[WIDTH-1],Asum[WIDTH-1:1]};
                Qtemp={Asum[0],Qin[WIDTH:1]};
            end
            2'b10: begin
                Atemp={Asub[WIDTH-1],Asub[WIDTH-1:1]};
                Qtemp={Asub[0],Qin[WIDTH:1]};
            end
        endcase
    end
    assign Aout=Atemp;
    assign Qout=Qtemp;
endmodule
