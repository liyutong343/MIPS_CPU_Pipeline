`timescale 1ns / 1ps
module HazardUnit(
    input wire reset,
    input wire ID_EX_MemRead,
    input wire [4:0] rt,
    input wire [4:0] rs,
    input wire [4:0] ID_EX_rt,
    output reg PCCont,
    output reg IF_IDCont,
    output reg ID_EXCont
);

    initial begin
        PCCont <= 1'b0;
        IF_IDCont <= 1'b0;
        ID_EXCont <= 1'b0;
    end

/*
    判断条件�?
ID_EX_MemRead（判断为Load指令�?
ID_EX_rt==rs || ID_EX_rt == rt（�?�察下一指令是否�?要use�?
实现结果�?
KEEP PC
KEEP IF_ID
FLUSH ID_EX

*/
always@(*) begin
    if(reset) begin
            PCCont <= 1'b0;
            IF_IDCont <= 1'b0;
            ID_EXCont <= 1'b0;
    end
    else if(ID_EX_MemRead && (ID_EX_rt==rs || ID_EX_rt == rt)) begin
        PCCont <= 1'b1;
        IF_IDCont <= 1'b1;
        ID_EXCont <= 1'b1;
    end
    else begin
        PCCont <= 1'b0;
        IF_IDCont <= 1'b0;
        ID_EXCont <= 1'b0;
    end
end

endmodule