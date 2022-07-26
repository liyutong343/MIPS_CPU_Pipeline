`timescale 1ns / 1ps
module IF_ID(
    input wire reset,
    input wire clk,
    input wire IF_IDCont,
    input wire [1:0] PCSrc,
    input wire [1:0] ID_EX_PCSrc,
    input wire [31:0] PCplus4,
    input wire [31:0] Instruction,
    output reg [31:0] IF_ID_PCplus4,
    output reg [31:0] IF_ID_Instruction
);

    initial begin
        IF_ID_PCplus4 <= 32'b0;
        IF_ID_Instruction <= 32'b0;
    end

    always @(posedge clk or posedge reset) begin
        if(reset) begin
            IF_ID_PCplus4 <= 32'b0;
            IF_ID_Instruction <= 32'b0; 
        end
        else begin
            if(!IF_IDCont) begin
                if(PCSrc || ID_EX_PCSrc == 2'b01) begin
                    // flush
                    IF_ID_PCplus4 <= 32'b0;
                    IF_ID_Instruction <= 32'b0; 
                end
                else begin
                    IF_ID_PCplus4 <= PCplus4;
                    IF_ID_Instruction <= Instruction; 
                end
            end
            else begin
                // keep, do nothing
            end
        end
    end



endmodule