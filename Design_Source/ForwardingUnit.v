`timescale 1ns / 1ps
module ForwardingUnit(
    input wire reset,
    input wire EX_MEM_RegWrite,
    input wire MEM_WB_RegWrite,
    input wire [4:0] ID_EX_rs,
    input wire [4:0] ID_EX_rt,
    input wire [4:0] EX_MEM_rt,
    input wire [4:0] EX_MEM_RegWriteAddr,
    input wire [4:0] MEM_WB_RegWriteAddr,
    output reg [1:0] Forward1,
    output reg [1:0] Forward2,
    output reg ForwardCopy
);
    initial begin
        Forward1 <= 2'b0;
        Forward2 <= 2'b0;
        ForwardCopy <= 1'b0;
    end

    always@(*) begin
        if(reset) begin
                Forward1 <= 2'b0;
                Forward2 <= 2'b0;
                ForwardCopy <= 1'b0;
        end
        else begin
    
        if(EX_MEM_RegWrite && EX_MEM_RegWriteAddr && EX_MEM_RegWriteAddr == ID_EX_rs) Forward1 <= 2'd1;         // Forwarding from ID is prior
        else if(MEM_WB_RegWrite && MEM_WB_RegWriteAddr && MEM_WB_RegWriteAddr == ID_EX_rs) Forward1 <= 2'd2;
        else Forward1 <= 2'd0;

        if(EX_MEM_RegWrite && EX_MEM_RegWriteAddr && EX_MEM_RegWriteAddr == ID_EX_rt) Forward2 <= 2'd1;
        else if (MEM_WB_RegWrite && MEM_WB_RegWriteAddr && MEM_WB_RegWriteAddr == ID_EX_rt) Forward2 <= 2'd2;
        else Forward2 <= 2'd0;

        if(MEM_WB_RegWrite && MEM_WB_RegWriteAddr && MEM_WB_RegWriteAddr == EX_MEM_rt) ForwardCopy <= 1'd1;
        else ForwardCopy <= 1'd0;
        
        end
    end



endmodule
