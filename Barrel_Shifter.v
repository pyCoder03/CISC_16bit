`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.04.2023 19:39:36
// Design Name: 
// Module Name: Barrel_Shifter
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


module Barrel_Shifter #(parameter WIDTH=8)(
    input[WIDTH-1:0] in,fill,   //Input
    input[3:0] sramt,           //Shift/Rotate Amount
    output reg[WIDTH-1:0] out 
    );
    
    always @(*) begin
//        case(mode)          //Case statements can be used for inputs only inside always blocks, else only constants can be used
//            3'b000: begin 
                case(sramt)
                    4'b0000: out=in;
                    4'b0001: if(WIDTH>1) out={in[WIDTH-2:0],fill[WIDTH-1:WIDTH-1]};
                    4'b0010: if(WIDTH>2) out={in[WIDTH-3:0],fill[WIDTH-1:WIDTH-2]};
                    4'b0011: if(WIDTH>3) out={in[WIDTH-4:0],fill[WIDTH-1:WIDTH-3]};
                    4'b0100: if(WIDTH>4) out={in[WIDTH-5:0],fill[WIDTH-1:WIDTH-4]};
                    4'b0101: if(WIDTH>5) out={in[WIDTH-6:0],fill[WIDTH-1:WIDTH-5]};
                    4'b0110: if(WIDTH>6) out={in[WIDTH-7:0],fill[WIDTH-1:WIDTH-6]};
                    4'b0111: if(WIDTH>7) out={in[WIDTH-8:0],fill[WIDTH-1:WIDTH-7]};
                    4'b1000: if(WIDTH>8) out={in[WIDTH-9:0],fill[WIDTH-1:WIDTH-8]};
                    4'b1000: if(WIDTH>9) out={in[WIDTH-10:0],fill[WIDTH-1:WIDTH-9]};
                    4'b1001: if(WIDTH>10) out={in[WIDTH-11:0],fill[WIDTH-1:WIDTH-10]};
                    4'b1010: if(WIDTH>11) out={in[WIDTH-12:0],fill[WIDTH-1:WIDTH-11]};
                    4'b1011: if(WIDTH>12) out={in[WIDTH-13:0],fill[WIDTH-1:WIDTH-12]};
                    4'b1100: if(WIDTH>13) out={in[WIDTH-14:0],fill[WIDTH-1:WIDTH-13]};
                    4'b1101: if(WIDTH>14) out={in[WIDTH-15:0],fill[WIDTH-1:WIDTH-14]};
                    4'b1110: if(WIDTH>15) out={in[WIDTH-16:0],fill[WIDTH-1:WIDTH-15]};
                    4'b1111: if(WIDTH>16) out=fill;
                endcase
//            end
//        endcase
    end
endmodule

module ALU_Shifter(
    input[15:0] in,
//    input[2:0] mode,
    /*
    Possible modes:
    3'b000: Arithmetic/Logical Shift Left
    3'b001: Arithmetic Shift Right
    3'b010: Logical Shift Right
    3'b011: Rotate Left
    3'b100: Rotate Right
    3'b101: Rotate Through Carry Left
    3'b110: Rotate Through Carry Right
    */
    input[2:0] mode,
    input[4:0] sramt,
    input carry,
    output reg[15:0] out
    );
    
    reg[16:0] fill,shift_in;
    wire[16:0] shift_out;
    Barrel_Shifter #(17) Shifter(
        .in(shift_in),
        .fill(fill),
        .sramt(sramt),
        .out(shift_out)
        );
    always @(*) begin
        case(mode)
            3'b000: begin
            fill=0;
            shift_in=in;
            out=shift_out;
            end
            3'b001: begin
            fill={16{in[15]}};
            shift_in=in[15-:16];
            out=shift_out[15-:16];
            end
            3'b010: begin
            fill=0;
            shift_in=in[15-:16];
            out=shift_out[15-:16];
            end
        endcase
    end
 endmodule
    