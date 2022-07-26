`timescale 1ns / 1ps
// 可以考虑加一个flag信号，用于表示branch来到了EX阶段
module BranchUnit(
    input wire reset,
    input wire [2:0] ID_EX_BranchOp,
    input wire [31:0] ALUout,
    input wire [31:0] BranchAddr,
    input wire [31:0] ID_EX_PCplus4,
    output reg [31:0] BranchTarget
);
    initial begin
        BranchTarget <= 32'b0;
    end

    always@(*) begin
    if(reset) begin
        BranchTarget <= 32'b0;        
    end
    else begin
        case(ID_EX_BranchOp)
            3'd0: begin
                // beq
                if(!ALUout) BranchTarget <= BranchAddr;
                else BranchTarget <= ID_EX_PCplus4;
            end
            3'd1: begin
                // bne
                if(ALUout) BranchTarget <= BranchAddr;
                else BranchTarget <= ID_EX_PCplus4;
            end
            3'd2: begin
                // blez
                if(ALUout) BranchTarget <= BranchAddr;
                else BranchTarget <= ID_EX_PCplus4;
            end
            3'd3: begin
                // bgtz
                if(ALUout) BranchTarget <= BranchAddr;
                else BranchTarget <= ID_EX_PCplus4;
            end
            3'd4: begin
                // bltz
                if(ALUout) BranchTarget <= BranchAddr;
                else BranchTarget <= ID_EX_PCplus4;
            end
            default: begin
                BranchTarget <= ID_EX_PCplus4;
            end

        endcase
        end
    end

endmodule