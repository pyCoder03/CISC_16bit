`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.04.2023 08:57:52
// Design Name: 
// Module Name: Bus_Interface_Unit
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


module Bus_Interface_Unit(ale,den_,rd_,wr_,dtr_syn,dtr_,busint,t_state);
input dtr_,busint;
output reg rd_=1'b1,wr_=1'b1,ale=1'b0,den_=1'b1,dtr_syn;
input[2:0] t_state=3'b000;
reg sig=1,busint_syn=0;
always @(*) begin
    if(busint_syn==0) begin
        rd_=1'b1;
        wr_=1'b1;
        end
    else if(dtr_syn) begin
        wr_=sig;
        rd_=1'b1;
        end
    else begin
        rd_=sig;
        wr_=1'b1;
        end
end
always @(*) begin
    case(t_state)
        3'b000: begin
            dtr_syn=dtr_;
            busint_syn=busint;
            if(busint_syn) ale=1'b1;
            end
        3'b010: begin
            if(busint_syn) begin
                ale=1'b0;
                sig=1'b0;
                den_=1'b0;
                end
            end
        3'b110: begin
            if(busint_syn) begin    
                sig=1'b1;
                end
            end
        3'b111: begin
            if(busint_syn) den_=1'b1;
            end
    endcase
end
endmodule
