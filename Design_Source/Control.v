`timescale 1ns / 1ps
module Control
(
    input wire reset,
    input wire [5:0] OpCode,
    input wire [5:0] Funct,
    output reg [1:0] PCSrc,
    output reg RegWrite,
    output reg [1:0] RegDst,
    output reg MemRead,
    output reg MemWrite,
    output reg [1:0] MemtoReg,
    output reg ALUSrc1,
    output reg ALUSrc2,
    output reg ExtOp,
    output reg LuiOp,
    output reg [2:0] BranchOp
);

initial begin
    PCSrc <= 2'b00;
    RegWrite <= 1'b0;
    RegDst <= 2'b00;
    MemRead <= 1'b0;
    MemWrite <= 1'b0;
    MemtoReg <= 2'b00;
    ALUSrc1 <= 1'b0;
    ALUSrc2 <= 1'b0;
    ExtOp <= 1'b0;
    LuiOp <= 1'b0;
    BranchOp <= 3'b000;

end

// Control signal
always@*
        begin
        if(reset) begin
            PCSrc <= 2'b00;
            RegWrite <= 1'b0;
            RegDst <= 2'b00;
            MemRead <= 1'b0;
            MemWrite <= 1'b0;
            MemtoReg <= 2'b00;
            ALUSrc1 <= 1'b0;
            ALUSrc2 <= 1'b0;
            ExtOp <= 1'b0;
            LuiOp <= 1'b0;
            BranchOp <= 3'b000;
        end
        else begin
            case(OpCode)
                6'h23: begin
                    // lw
					PCSrc <= 2'b00;
					RegWrite <= 1'b1;
					RegDst <= 2'b01;
					MemRead <= 1'b1;
					MemWrite <= 1'b0;
					MemtoReg <= 2'b01;
					ALUSrc1 <= 1'b0;
					ALUSrc2 <= 1'b1;
					ExtOp <= 1'b1;
					LuiOp <= 1'b0;
					
					BranchOp <= 3'b0;
                end
                6'h2b: begin
                    // sw
					PCSrc <= 2'b00;
					RegWrite <= 1'b0;
					MemRead <= 1'b0;
					MemWrite <= 1'b1;
					ALUSrc1 <= 1'b0;
					ALUSrc2 <= 1'b1;
					ExtOp <= 1'b1;
					LuiOp <= 1'b0;
					
					RegDst <= 2'b0;
					MemtoReg <= 2'b0;
					BranchOp <= 3'b0;
                    
                end
                6'h0f: begin
                    // lui
					PCSrc <= 2'b00;
					RegWrite <= 1'b1;
					RegDst <= 2'b01;
					MemRead <= 1'b0;
					MemWrite <= 1'b0;
					MemtoReg <= 2'b00;
					ALUSrc1 <= 1'b0;
					ALUSrc2 <= 1'b1;
					LuiOp <= 1'b1;
					
					ExtOp <= 1'b0;
					BranchOp <= 3'b0;
                    
                end
                6'h08: begin
                    // addi
					PCSrc <= 2'b00;
					RegWrite <= 1'b1;
					RegDst <= 2'b01;
					MemRead <= 1'b0;
					MemWrite <= 1'b0;
					MemtoReg <= 2'b00;
					ALUSrc1 <= 1'b0;
					ALUSrc2 <= 1'b1;
					ExtOp <= 1'b1;
					LuiOp <= 1'b0;
					BranchOp <= 3'b0;
                    
                end
                6'h09: begin
                    // addiu
					PCSrc <= 2'b00;
					RegWrite <= 1'b1;
					RegDst <= 2'b01;
					MemRead <= 1'b0;
					MemWrite <= 1'b0;
					MemtoReg <= 2'b00;
					ALUSrc1 <= 1'b0;
					ALUSrc2 <= 1'b1;
					ExtOp <= 1'b1;
					LuiOp <= 1'b0;
					BranchOp <= 3'b0;
                    
                end
                6'h0a: begin
                    // slti
                    PCSrc <= 2'b00;
					RegWrite <= 1'b1;
					RegDst <= 2'b01;
					MemRead <= 1'b0;
					MemWrite <= 1'b0;
					MemtoReg <= 2'b00;
					ALUSrc1 <= 1'b0;
					ALUSrc2 <= 1'b1;
					ExtOp <= 1'b1;
					LuiOp <= 1'b0;
					BranchOp <= 3'b0;
                end
                6'h0b: begin
                    // sltiu
                    PCSrc <= 2'b00;
					RegWrite <= 1'b1;
					RegDst <= 2'b01;
					MemRead <= 1'b0;
					MemWrite <= 1'b0;
					MemtoReg <= 2'b00;
					ALUSrc1 <= 1'b0;
					ALUSrc2 <= 1'b1;
					ExtOp <= 1'b1;
					LuiOp <= 1'b0;
					BranchOp <= 3'b0;
                end
                6'h0c: begin
                    // andi
                    PCSrc <= 2'b00;
					RegWrite <= 1'b1;
					RegDst <= 2'b01;
					MemRead <= 1'b0;
					MemWrite <= 1'b0;
					MemtoReg <= 2'b00;
					ALUSrc1 <= 1'b0;
					ALUSrc2 <= 1'b1;
					ExtOp <= 1'b0;
					LuiOp <= 1'b0;
					BranchOp <= 3'b0;
                end
                6'h0d: begin
                    // ori
                    PCSrc <= 2'b00;
					RegWrite <= 1'b1;
					RegDst <= 2'b01;
					MemRead <= 1'b0;
					MemWrite <= 1'b0;
					MemtoReg <= 2'b00;
					ALUSrc1 <= 1'b0;
					ALUSrc2 <= 1'b1;
					ExtOp <= 1'b0;
					LuiOp <= 1'b0;
					BranchOp <= 3'b0;
                end               
                6'h04: begin
                    // beq
                    PCSrc <= 2'b01;
					RegWrite <= 1'b0;
					MemRead <= 1'b0;
					MemWrite <= 1'b0;
					ALUSrc1 <= 1'b0;
					ALUSrc2 <= 1'b0;
					ExtOp <= 1'b1;
					LuiOp <= 1'b0;
                    BranchOp <= 3'd0;
                    
                    RegDst <= 2'b0;
                    MemtoReg <= 2'b0;
                end
                6'h05: begin
                    // bne
                    PCSrc <= 2'b01;
					RegWrite <= 1'b0;
					MemRead <= 1'b0;
					MemWrite <= 1'b0;
					ALUSrc1 <= 1'b0;
					ALUSrc2 <= 1'b0;
					ExtOp <= 1'b1;
					LuiOp <= 1'b0;
                    BranchOp <= 3'd1;
                    
                    RegDst <= 2'b0;
                    MemtoReg <= 2'b0;
                end
                6'h06: begin
                    // blez
                    PCSrc <= 2'b01;
					RegWrite <= 1'b0;
					MemRead <= 1'b0;
					MemWrite <= 1'b0;
					ALUSrc1 <= 1'b0;
					ALUSrc2 <= 1'b0;
					ExtOp <= 1'b1;
					LuiOp <= 1'b0;
                    BranchOp <= 3'd2;
                    
                    RegDst <= 2'b0;
                    MemtoReg <= 2'b0;
                end
                6'h07: begin
                    // bgtz
                    PCSrc <= 2'b01;
					RegWrite <= 1'b0;
					MemRead <= 1'b0;
					MemWrite <= 1'b0;
					ALUSrc1 <= 1'b0;
					ALUSrc2 <= 1'b0;
					ExtOp <= 1'b1;
					LuiOp <= 1'b0;
                    BranchOp <= 3'd3;
                    
                    RegDst <= 2'b0;
                    MemtoReg <= 2'b0;
                end
                6'h01: begin
                    // bltz
                    PCSrc <= 2'b01;
					RegWrite <= 1'b0;
					MemRead <= 1'b0;
					MemWrite <= 1'b0;
					ALUSrc1 <= 1'b0;
					ALUSrc2 <= 1'b0;
					ExtOp <= 1'b1;
					LuiOp <= 1'b0;
                    BranchOp <= 3'd4;
                    
                    RegDst <= 2'b0;
                    MemtoReg <= 2'b0;
                end
				6'h02: begin
                    // j
					PCSrc <= 2'b10;
					RegWrite <= 1'b0;
					MemRead <= 1'b0;
					MemWrite <= 1'b0;
					
					RegDst <= 2'b0;
					MemtoReg <= 2'b0;
					ALUSrc1 <= 1'b0;
                    ALUSrc2 <= 1'b0;
                    ExtOp <= 1'b0;
                    LuiOp <= 1'b0;
                    BranchOp <= 3'b0;
                    
                end
				6'h03: begin
                    // jal
					PCSrc <= 2'b10;
					RegWrite <= 1'b1;
					RegDst <= 2'b10;
					MemRead <= 1'b0;
					MemWrite <= 1'b0;
					MemtoReg <= 2'b10;
					ALUSrc1 <= 1'b0;
                    ALUSrc2 <= 1'b0;
                    ExtOp <= 1'b0;
                    LuiOp <= 1'b0;
                    BranchOp <= 3'b0;
                    
                end
                6'h00: begin
                    case(Funct)
                        6'h20: begin
                            // add
							PCSrc <= 2'b00;
	
							RegWrite <= 1'b1;
							RegDst <= 2'b00;
							MemRead <= 1'b0;
							MemWrite <= 1'b0;
							MemtoReg <= 2'b00;
							ALUSrc1 <= 1'b0;
							ALUSrc2 <= 1'b0;
							ExtOp <= 1'b0;
							LuiOp <= 1'b0;
							BranchOp <= 3'b0;
                            
                        end
                        6'h21: begin
                            // addu
							PCSrc <= 2'b00;
	
							RegWrite <= 1'b1;
							RegDst <= 2'b00;
							MemRead <= 1'b0;
							MemWrite <= 1'b0;
							MemtoReg <= 2'b00;
							ALUSrc1 <= 1'b0;
							ALUSrc2 <= 1'b0;
							ExtOp <= 1'b0;
							LuiOp <= 1'b0;
							BranchOp <= 3'b0;
                            
                        end
                        6'h22: begin
                            // sub
							PCSrc <= 2'b00;
	
							RegWrite <= 1'b1;
							RegDst <= 2'b00;
							MemRead <= 1'b0;
							MemWrite <= 1'b0;
							MemtoReg <= 2'b00;
							ALUSrc1 <= 1'b0;
							ALUSrc2 <= 1'b0;
							ExtOp <= 1'b0;
							LuiOp <= 1'b0;
							BranchOp <= 3'b0;
                            
                        end
                        6'h23: begin
                            // subu
							PCSrc <= 2'b00;
	
							RegWrite <= 1'b1;
							RegDst <= 2'b00;
							MemRead <= 1'b0;
							MemWrite <= 1'b0;
							MemtoReg <= 2'b00;
							ALUSrc1 <= 1'b0;
							ALUSrc2 <= 1'b0;
                            ExtOp <= 1'b0;
                            LuiOp <= 1'b0;
                            BranchOp <= 3'b0;
                            
                        end
                        6'h24: begin
                            // and
							PCSrc <= 2'b00;
	
							RegWrite <= 1'b1;
							RegDst <= 2'b00;
							MemRead <= 1'b0;
							MemWrite <= 1'b0;
							MemtoReg <= 2'b00;
							ALUSrc1 <= 1'b0;
							ALUSrc2 <= 1'b0;
                            ExtOp <= 1'b0;
                            LuiOp <= 1'b0;
                            BranchOp <= 3'b0;
                            
                        end
                        6'h25: begin
                            // or
							PCSrc <= 2'b00;
	
							RegWrite <= 1'b1;
							RegDst <= 2'b00;
							MemRead <= 1'b0;
							MemWrite <= 1'b0;
							MemtoReg <= 2'b00;
							ALUSrc1 <= 1'b0;
							ALUSrc2 <= 1'b0;
                            ExtOp <= 1'b0;
                            LuiOp <= 1'b0;
                            BranchOp <= 3'b0;
                            
                        end
                        6'h26: begin
                            // xor
							PCSrc <= 2'b00;
	
							RegWrite <= 1'b1;
							RegDst <= 2'b00;
							MemRead <= 1'b0;
							MemWrite <= 1'b0;
							MemtoReg <= 2'b00;
							ALUSrc1 <= 1'b0;
							ALUSrc2 <= 1'b0;
							ExtOp <= 1'b0;
							LuiOp <= 1'b0;
							BranchOp <= 3'b0;
                            
                        end
                        6'h27: begin
                            // nor
							PCSrc <= 2'b00;
	
							RegWrite <= 1'b1;
							RegDst <= 2'b00;
							MemRead <= 1'b0;
							MemWrite <= 1'b0;
							MemtoReg <= 2'b00;
							ALUSrc1 <= 1'b0;
							ALUSrc2 <= 1'b0;
							ExtOp <= 1'b0;
							LuiOp <= 1'b0;
							BranchOp <= 3'b0;
                            
                        end
                        6'h00: begin
                            // sll
							PCSrc <= 2'b00;
	
							RegWrite <= 1'b1;
							RegDst <= 2'b00;
							MemRead <= 1'b0;
							MemWrite <= 1'b0;
							MemtoReg <= 2'b00;
							ALUSrc1 <= 1'b1;
							ALUSrc2 <= 1'b0;
							ExtOp <= 1'b0;
							LuiOp <= 1'b0;
							BranchOp <= 3'b0;
                            
                        end
                        6'h02: begin
                            // srl
							PCSrc <= 2'b00;
	
							RegWrite <= 1'b1;
							RegDst <= 2'b00;
							MemRead <= 1'b0;
							MemWrite <= 1'b0;
							MemtoReg <= 2'b00;
							ALUSrc1 <= 1'b1;
							ALUSrc2 <= 1'b0;
							ExtOp <= 1'b0;
							LuiOp <= 1'b0;
							BranchOp <= 3'b0;
                            
                        end
                        6'h03: begin
                            // sra
							PCSrc <= 2'b00;
	
							RegWrite <= 1'b1;
							RegDst <= 2'b00;
							MemRead <= 1'b0;
							MemWrite <= 1'b0;
							MemtoReg <= 2'b00;
							ALUSrc1 <= 1'b1;
							ALUSrc2 <= 1'b0;
							ExtOp <= 1'b0;
							LuiOp <= 1'b0;
							BranchOp <= 3'b0;
                            
                        end
                        6'h2a: begin
                            // slt
							PCSrc <= 2'b00;
	
							RegWrite <= 1'b1;
							RegDst <= 2'b00;
							MemRead <= 1'b0;
							MemWrite <= 1'b0;
							MemtoReg <= 2'b00;
							ALUSrc1 <= 1'b0;
							ALUSrc2 <= 1'b0;
							ExtOp <= 1'b0;
							LuiOp <= 1'b0;
							BranchOp <= 3'b0;
                            
                        end
                        6'h2b: begin
                            // sltu
							PCSrc <= 2'b00;
	
							RegWrite <= 1'b1;
							RegDst <= 2'b00;
							MemRead <= 1'b0;
							MemWrite <= 1'b0;
							MemtoReg <= 2'b00;
							ALUSrc1 <= 1'b0;
							ALUSrc2 <= 1'b0;
							ExtOp <= 1'b0;
							LuiOp <= 1'b0;
							BranchOp <= 3'b0;
                            
                        end
						6'h08: begin
                            // jr
							PCSrc <= 2'b11;
	
							RegWrite <= 1'b0;
							MemRead <= 1'b0;
							MemWrite <= 1'b0;
							
							RegDst <= 2'b0;
							MemtoReg <= 2'b0;
							ALUSrc1 <= 1'b0;
                            ALUSrc2 <= 1'b0;
                            ExtOp <= 1'b0;
                            LuiOp <= 1'b0;
                            BranchOp <= 3'b0;
                            
                        end
						6'h09: begin
                            // jalr
							PCSrc <= 2'b11;
	
							RegWrite <= 1'b1;
							RegDst <= 2'b00;
							MemRead <= 1'b0;
							MemWrite <= 1'b0;
							MemtoReg <= 2'b10;
							ALUSrc1 <= 1'b0;
                            ALUSrc2 <= 1'b0;
                            ExtOp <= 1'b0;
                            LuiOp <= 1'b0;
                            BranchOp <= 3'b0;
                            
                        end
                        default: begin
                            PCSrc <= 2'b0;
                            RegWrite <= 1'b0;
                            RegDst <= 2'b0;
                            MemRead <= 1'b0;
                            MemWrite <= 1'b0;
                            MemtoReg <= 2'b0;
                            ALUSrc1 <= 1'b0;
                            ALUSrc2 <= 1'b0;
                            ExtOp <= 1'b0;
                            LuiOp <= 1'b0;
                            BranchOp <= 3'b0;
                            
                        end
                    endcase
                end
                default: begin
                    PCSrc <= 2'b0;
                    RegWrite <= 1'b0;
                    RegDst <= 2'b0;
                    MemRead <= 1'b0;
                    MemWrite <= 1'b0;
                    MemtoReg <= 2'b0;
                    ALUSrc1 <= 1'b0;
                    ALUSrc2 <= 1'b0;
                    ExtOp <= 1'b0;
                    LuiOp <= 1'b0;
                    BranchOp <= 3'b0;
                end
            endcase
            end
        end
	
endmodule