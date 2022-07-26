`timescale 1ns / 1ps
module ID_EX(
    input wire reset,
    input wire clk,
    input wire ID_EXCont,
    input wire RegWrite,
    input wire [1:0] MemtoReg,
    input wire MemRead,
    input wire MemWrite,
    input wire [1:0] PCSrc,
    input wire [1:0] RegDst,
    input wire ALUSrc1,
    input wire ALUSrc2,
    input wire [2:0] BranchOp,
    input wire [3:0] ALUOp,
    input wire Sign,
    input wire [4:0] rt,
    input wire [4:0] rs,
    input wire [4:0] rd,
    input wire [4:0] shamt,
    input wire [31:0] IF_ID_PCplus4,
    input wire [31:0] RegReadData1,
    input wire [31:0] RegReadData2,
    input wire [31:0] immext,
    output reg ID_EX_RegWrite,
    output reg [1:0] ID_EX_MemtoReg,
    output reg ID_EX_MemRead,
    output reg ID_EX_MemWrite,
    output reg [1:0] ID_EX_PCSrc,
    output reg [1:0] ID_EX_RegDst,
    output reg ID_EX_ALUSrc1,
    output reg ID_EX_ALUSrc2,
    output reg [2:0] ID_EX_BranchOp,
    output reg [3:0] ID_EX_ALUOp,
    output reg ID_EX_Sign,
    output reg [4:0] ID_EX_rt,
    output reg [4:0] ID_EX_rs,
    output reg [4:0] ID_EX_rd,
    output reg [4:0] ID_EX_shamt,
    output reg [31:0] ID_EX_PCplus4,
    output reg [31:0] ID_EX_RegReadData1,
    output reg [31:0] ID_EX_RegReadData2,
    output reg [31:0] ID_EX_immext
);

    initial begin
        ID_EX_RegWrite <= 1'b0;
        ID_EX_MemtoReg <= 2'b00;
        ID_EX_MemRead <= 1'b0;
        ID_EX_MemWrite <= 1'b0;
        ID_EX_PCSrc <= 2'b00;
        ID_EX_RegDst <= 2'b00;
        ID_EX_ALUSrc1 <= 1'b0;
        ID_EX_ALUSrc2 <= 1'b0;
        ID_EX_BranchOp <= 3'b000;
        ID_EX_ALUOp <= 5'b00000;
        ID_EX_Sign <= 1'b0;
        ID_EX_rt <= 5'b00000;
        ID_EX_rs <= 5'b00000;
        ID_EX_rd <= 5'b00000;
        ID_EX_shamt <= 5'b00000;
        ID_EX_PCplus4 <= 32'h00000000;
        ID_EX_RegReadData1 <= 32'h00000000;
        ID_EX_RegReadData2 <= 32'h00000000;
        ID_EX_immext <= 32'h00000000;
    end

    always @(posedge clk or posedge reset) begin
        if(reset) begin
        ID_EX_RegWrite <= 1'b0;
        ID_EX_MemtoReg <= 2'b00;
        ID_EX_MemRead <= 1'b0;
        ID_EX_MemWrite <= 1'b0;
        ID_EX_PCSrc <= 2'b00;
        ID_EX_RegDst <= 2'b00;
        ID_EX_ALUSrc1 <= 1'b0;
        ID_EX_ALUSrc2 <= 1'b0;
        ID_EX_BranchOp <= 3'b000;
        ID_EX_ALUOp <= 5'b00000;
        ID_EX_Sign <= 1'b0;
        ID_EX_rt <= 5'b00000;
        ID_EX_rs <= 5'b00000;
        ID_EX_rd <= 5'b00000;
        ID_EX_shamt <= 5'b00000;
        ID_EX_PCplus4 <= 32'h00000000;
        ID_EX_RegReadData1 <= 32'h00000000;
        ID_EX_RegReadData2 <= 32'h00000000;
        ID_EX_immext <= 32'h00000000;
        end
        else begin
            if(ID_EXCont) begin
                // flush
                ID_EX_RegWrite <= 1'b0;
                ID_EX_MemtoReg <= 2'b0;
                ID_EX_MemRead <= 1'b0;
                ID_EX_MemWrite <= 1'b0;
                ID_EX_PCSrc <= 2'b0;
                ID_EX_RegDst <= 2'b0;
                ID_EX_ALUSrc1 <= 1'b0;
                ID_EX_ALUSrc2 <= 1'b0;
                ID_EX_BranchOp <= 3'b0;
                ID_EX_ALUOp <= 5'b0;
                ID_EX_Sign <= 1'b0;
                ID_EX_rt <= 5'b0;
                ID_EX_rs <= 5'b0;
                ID_EX_rd <= 5'b0;
                ID_EX_shamt <= 5'b0;
                ID_EX_PCplus4 <= 32'b0;
                ID_EX_RegReadData1 <= 32'b0;
                ID_EX_RegReadData2 <= 32'b0;
                ID_EX_immext <= 32'b0; 
            end
            else begin
                ID_EX_RegWrite <= RegWrite;
                ID_EX_MemtoReg <= MemtoReg;
                ID_EX_MemRead <= MemRead;
                ID_EX_MemWrite <= MemWrite;
                ID_EX_PCSrc <= PCSrc;
                ID_EX_RegDst <= RegDst;
                ID_EX_ALUSrc1 <= ALUSrc1;
                ID_EX_ALUSrc2 <= ALUSrc2;
                ID_EX_BranchOp <= BranchOp;
                ID_EX_ALUOp <= ALUOp;
                ID_EX_Sign <= Sign;
                ID_EX_rt <= rt;
                ID_EX_rs <= rs;
                ID_EX_rd <= rd;
                ID_EX_shamt <= shamt;
                ID_EX_PCplus4 <= IF_ID_PCplus4;
                ID_EX_RegReadData1 <= RegReadData1; 
                ID_EX_RegReadData2 <= RegReadData2;
                ID_EX_immext <= immext;
            end
        end
    end

endmodule