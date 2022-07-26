`timescale 1ns / 1ps
module ALUControl
(
    input wire reset,
    input wire [5:0] OpCode,
    input wire [5:0] Funct,
    output reg [3:0] ALUOp,
    output reg Sign
);
    parameter ADD = 5'd0;
    parameter SUB = 5'd1;
    parameter AND = 5'd2;
    parameter OR = 5'd3;
    parameter XOR = 5'd4;
    parameter NOR = 5'd5;
    parameter SL = 5'd6;
    parameter SR = 5'd7;
    parameter LT = 5'd8;
    parameter LE = 5'd9;
    parameter GT = 5'd10;

    initial begin
        ALUOp <= 5'b00000;
        Sign <= 1'b0;
    end


    always@*
        begin
        if(reset) begin
                ALUOp <= 5'b00000;
                Sign <= 1'b0;
        end
        else begin
            case(OpCode)
                6'h23: begin
                    // lw
                    ALUOp <= ADD;
                    Sign <= 1'b1;
                end
                6'h2b: begin
                    // sw
                    ALUOp <= ADD;
                    Sign <= 1'b1;
                end
                6'h0f: begin
                    // lui
                    ALUOp <= ADD;
                    Sign <= 1'b0;
                end
                6'h08: begin
                    // addi
                    ALUOp <= ADD;
                    Sign <= 1'b1;
                end
                6'h09: begin
                    // addiu
                    ALUOp <= ADD;
                    Sign <= 1'b0;
                end
                6'h0c: begin
                    // andi
                    ALUOp <= AND;
                    Sign <= 1'b0;
                end
                6'h0d: begin
                    // ori
                    ALUOp <= OR;
                    Sign <= 1'b0;
                end
                6'h0a: begin
                    // slti
                    ALUOp <= LT;
                    Sign <= 1'b1;
                end
                6'h0b: begin
                    // sltiu
                    ALUOp <= LT;
                    Sign <= 1'b0;
                end
                6'h04: begin
                    // beq
                    ALUOp <= SUB;
                    Sign <= 1'b0;   // Don't care
                end
                6'h05: begin
                    // bne
                    ALUOp <= SUB;
                    Sign <= 1'b0;
                end
                6'h06: begin
                    // blez
                    ALUOp <= LE;
                    Sign <= 1'b0;
                end
                6'h07: begin
                    // bgtz
                    ALUOp <= GT;
                    Sign <= 1'b0;
                end
                6'h01: begin
                    // bltz
                    ALUOp <= LT;
                    Sign <= 1'b0;
                end
                6'h00: begin
                    case(Funct)
                        6'h20: begin
                            // add
                            ALUOp <= ADD;
                            Sign <= 1'b1;
                        end
                        6'h21: begin
                            // addu
                            ALUOp <= ADD;
                            Sign <= 1'b0;
                        end
                        6'h22: begin
                            // sub
                            ALUOp <= SUB;
                            Sign <= 1'b1;
                        end
                        6'h23: begin
                            // subu
                            ALUOp <= SUB;
                            Sign <= 1'b0;
                        end
                        6'h24: begin
                            // and
                            ALUOp <= AND;
                            Sign <= 1'b0;
                        end
                        6'h25: begin
                            // or
                            ALUOp <= OR;
                            Sign <= 1'b0;
                        end
                        6'h26: begin
                            // xor
                            ALUOp <= XOR;
                            Sign <= 1'b0;
                        end
                        6'h27: begin
                            // nor
                            ALUOp <= NOR;
                            Sign <= 1'b0;
                        end
                        6'h00: begin
                            // sll
                            ALUOp <= SL;
                            Sign <= 1'b0;
                        end
                        6'h02: begin
                            // srl
                            ALUOp <= SR;
                            Sign <= 1'b0;
                        end
                        6'h03: begin
                            // sra
                            ALUOp <= SR;
                            Sign <= 1'b1;
                        end
                        6'h2a: begin
                            // slt
                            ALUOp <= LT;
                            Sign <= 1'b1;
                        end
                        6'h2b: begin
                            // sltu
                            ALUOp <= LT;
                            Sign <= 1'b0;
                        end
                        default: begin
                        
                                ALUOp <= 4'b0;
                                Sign <= 1'b0;
                        end
                    endcase
                end
                default: begin
                
                        ALUOp <= 4'b0;
                        Sign <= 1'b0;
                end
            endcase
            end
        end

endmodule