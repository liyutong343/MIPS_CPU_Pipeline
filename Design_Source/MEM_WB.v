`timescale 1ns / 1ps
module MEM_WB(
    input wire reset,
    input wire clk,
    input wire EX_MEM_RegWrite,
    input wire [1:0] EX_MEM_MemtoReg,
    input wire [31:0] EX_MEM_PCplus4,
    input wire [31:0] EX_MEM_ALUout,
    input wire [4:0] EX_MEM_RegWriteAddr,
    input wire [31:0] MemReadData,
    output reg MEM_WB_RegWrite,
    output reg [1:0] MEM_WB_MemtoReg,
    output reg [31:0] MEM_WB_PCplus4,
    output reg [31:0] MEM_WB_ALUout,
    output reg [4:0] MEM_WB_RegWriteAddr,
    output reg [31:0] MEM_WB_MemReadData
);

    initial begin
        MEM_WB_RegWrite <= 1'b0;
        MEM_WB_MemtoReg <= 2'b0;
        MEM_WB_PCplus4 <= 32'b0;
        MEM_WB_ALUout <= 32'b0;
        MEM_WB_RegWriteAddr <= 5'b0;
        MEM_WB_MemReadData <= 32'b0;
    end

    always @(posedge clk or posedge reset) begin
        if(reset) begin
            MEM_WB_RegWrite <= 1'b0;
            MEM_WB_MemtoReg <= 2'b0;
            MEM_WB_PCplus4 <= 32'b0;
            MEM_WB_ALUout <= 32'b0;
            MEM_WB_RegWriteAddr <= 5'b0;
            MEM_WB_MemReadData <= 32'b0;
        end
        else begin
            MEM_WB_RegWrite <= EX_MEM_RegWrite;
            MEM_WB_MemtoReg <= EX_MEM_MemtoReg;
            MEM_WB_PCplus4 <= EX_MEM_PCplus4;
            MEM_WB_ALUout <= EX_MEM_ALUout;
            MEM_WB_RegWriteAddr <= EX_MEM_RegWriteAddr;
            MEM_WB_MemReadData <= MemReadData;
        end
    end

endmodule