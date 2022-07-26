`timescale 1ns / 1ps
module PC(
    input wire reset,
    input wire clk,
    input wire [1:0] PCSrc,
    input wire [1:0] ID_EX_PCSrc,
    input wire PCcont,
    input wire [31:0] IF_ID_PCplus4,
    input wire [31:0] BranchTarget,
    input wire [25:0] target,
    input wire [31:0] RegReadData1,
    output reg [31:0] pc
);
    initial begin
        pc <= 32'h00400000;
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // reset
            pc <= 32'h00400000;
        end
        else if(!PCcont) begin
            // doesn't need to keep
            if(PCSrc == 2'b10) begin
                // j or jal
                pc <= {IF_ID_PCplus4[31:28], target << 2};
            end
            else if(PCSrc == 2'b11) begin
                // jr or jalr
                pc <= RegReadData1;
            end
            else if(ID_EX_PCSrc == 2'b01) begin
                // branch
                pc <= BranchTarget;
            end
            else begin
                pc <= pc + 4;
            end  
        end
        else begin
            // keep
        end
    end

endmodule