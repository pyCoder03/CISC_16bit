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
input[2:0] t_state=3'b000;
output rd_,wr_,ale,den_;
output reg dtr_syn;

reg rd_=1'b1,wr_=1'b1;
reg busint_syn=0;
wire sig,den_,a,b,ta,ale;

wire t2,t1,t0;
assign {t2,t1,t0}=t_state;
assign ta=t2&t1&t0;
//assign rd_=rd_,wr_=wr_,ale=ale_,den_=den_,sig=sig;

//assign rd_=(
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

always @(negedge ta) begin
        dtr_syn=dtr_;
        busint_syn=busint;
end

assign a=t2&t1,b=~(t2|t1),sig=(~busint_syn)|a|b,den_=(~busint_syn)|(a&t0)|b,ale=busint_syn&~(t2|t1);

endmodule
