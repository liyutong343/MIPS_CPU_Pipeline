`timescale 1ns / 1ps
module EX_MEM(
    input wire reset,
    input wire clk,
    input wire ID_EX_RegWrite,
    input wire [1:0] ID_EX_MemtoReg,
    input wire ID_EX_MemRead,
    input wire ID_EX_MemWrite,
    input wire [4:0] ID_EX_rt,
    input wire [31:0] ID_EX_PCplus4,
    input wire [31:0] ID_EX_RegReadData2,
    input wire [31:0] ALUout,
    input wire [4:0] RegWriteAddr,
    output reg EX_MEM_RegWrite,
    output reg [1:0] EX_MEM_MemtoReg,
    output reg EX_MEM_MemRead,
    output reg EX_MEM_MemWrite,
    output reg [4:0] EX_MEM_rt,
    output reg [31:0] EX_MEM_PCplus4,
    output reg [31:0] EX_MEM_RegReadData2,
    output reg [31:0] EX_MEM_ALUout,
    output reg [4:0] EX_MEM_RegWriteAddr
);

    initial begin
        EX_MEM_RegWrite <= 1'b0;
        EX_MEM_MemtoReg <= 2'b0;
        EX_MEM_MemRead <= 1'b0;
        EX_MEM_MemWrite <= 1'b0;
        EX_MEM_rt <= 5'b0;
        EX_MEM_PCplus4 <= 32'b0;
        EX_MEM_RegReadData2 <= 32'b0;
        EX_MEM_ALUout <= 32'b0;
        EX_MEM_RegWriteAddr <= 5'b0;
    end

    always @(posedge clk or posedge reset) begin
        if(reset) begin
            EX_MEM_RegWrite <= 1'b0;
            EX_MEM_MemtoReg <= 2'b00;
            EX_MEM_MemRead <= 1'b0;
            EX_MEM_MemWrite <= 1'b0;
            EX_MEM_rt <= 5'b00000;
            EX_MEM_PCplus4 <= 32'h00000000;
            EX_MEM_RegReadData2 <= 32'h00000000;
            EX_MEM_ALUout <= 32'h00000000;
            EX_MEM_RegWriteAddr <= 5'b00000;
        end
        else begin
            EX_MEM_RegWrite <= ID_EX_RegWrite;
            EX_MEM_MemtoReg <= ID_EX_MemtoReg;
            EX_MEM_MemRead <= ID_EX_MemRead;
            EX_MEM_MemWrite <= ID_EX_MemWrite;
            EX_MEM_rt <= ID_EX_rt;
            EX_MEM_PCplus4 <= ID_EX_PCplus4;
            EX_MEM_RegReadData2 <= ID_EX_RegReadData2;
            EX_MEM_ALUout <= ALUout;
            EX_MEM_RegWriteAddr <= RegWriteAddr;
        end
    end

endmodule