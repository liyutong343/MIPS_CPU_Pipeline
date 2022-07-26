`timescale 1ns / 1ps
module CPU(
    input reset,
    input system_clk,
    output reg [3:0] AN,
    output reg [7:0] BCD,
    output [7:0] small_pc
);
    
    wire clk;
    assign clk = system_clk;
    //clk_gen Myclk_gen(reset, system_clk,clk);

    /* ID */
    wire [31:0] IF_ID_PCplus4;
    wire [31:0] IF_ID_Instruction;

    // Decode
    wire [5:0] OpCode;
    wire [4:0] rs;
    wire [4:0] rt;
    wire [4:0] rd;
    wire [4:0] shamt;
    wire [5:0] Funct;
    wire [15:0] imm;
    wire [25:0] target;
    assign OpCode = IF_ID_Instruction[31:26];
    assign rs = IF_ID_Instruction[25:21];
    assign rt = IF_ID_Instruction[20:16];
    assign rd = IF_ID_Instruction[15:11];
    assign shamt = IF_ID_Instruction[10:6];
    assign Funct = IF_ID_Instruction[5:0];
    assign imm = IF_ID_Instruction[15:0];
    assign target = IF_ID_Instruction[25:0];

    // Control
    wire [1:0] PCSrc;
    wire RegWrite;
    wire [1:0] RegDst;
    wire MemRead;
    wire MemWrite;
    wire [1:0] MemtoReg;
    wire ALUSrc1;
    wire ALUSrc2;
    wire ExtOp;
    wire LuiOp;
    wire [2:0] BranchOp;
    Control MyControl(reset, OpCode, Funct, PCSrc, RegWrite, RegDst, MemRead, 
    MemWrite, MemtoReg, ALUSrc1, ALUSrc2, ExtOp, LuiOp, BranchOp);

    // ALUControl
    wire [3:0] ALUOp;
    wire Sign;
    ALUControl MyALUControl(reset, OpCode, Funct, ALUOp, Sign);

    // ImmExt
    wire [31:0] immext;
    assign immext = LuiOp? imm << 16 : {ExtOp? {16{imm[15]}} : 16'h0000, imm}; 

    // RegisterFile
    // instantiation is in the WB step
    wire [31:0] RegReadData1;
    wire [31:0] RegReadData2;

    /* ID/EX */
    wire ID_EXCont;    // generate by hazard unit
    wire ID_EX_RegWrite;
    wire [1:0] ID_EX_MemtoReg;
    wire ID_EX_MemRead;
    wire ID_EX_MemWrite;
    wire [1:0] ID_EX_PCSrc;
    wire [1:0] ID_EX_RegDst;
    wire ID_EX_ALUSrc1;
    wire ID_EX_ALUSrc2;
    wire [2:0] ID_EX_BranchOp;
    wire [3:0] ID_EX_ALUOp;
    wire ID_EX_Sign;
    wire [4:0] ID_EX_rt;
    wire [4:0] ID_EX_rs;
    wire [4:0] ID_EX_rd;
    wire [4:0] ID_EX_shamt;
    wire [31:0] ID_EX_PCplus4;
    wire [31:0] ID_EX_RegReadData1;
    wire [31:0] ID_EX_RegReadData2;
    wire [31:0] ID_EX_immext;
    ID_EX MyID_EX(reset, clk, ID_EXCont, RegWrite, MemtoReg, MemRead, 
    MemWrite, PCSrc, RegDst, ALUSrc1, ALUSrc2, BranchOp, ALUOp, Sign, 
    rt, rs, rd, shamt, IF_ID_PCplus4, RegReadData1, RegReadData2, immext, 
    ID_EX_RegWrite, ID_EX_MemtoReg, ID_EX_MemRead, ID_EX_MemWrite, 
    ID_EX_PCSrc, ID_EX_RegDst, ID_EX_ALUSrc1, ID_EX_ALUSrc2, ID_EX_BranchOp, 
    ID_EX_ALUOp, ID_EX_Sign, ID_EX_rt, ID_EX_rs, ID_EX_rd, ID_EX_shamt, 
    ID_EX_PCplus4, ID_EX_RegReadData1, ID_EX_RegReadData2, ID_EX_immext);

    /* EX */
    wire [1:0] Forward1;  // generate by forwarding unit
    wire [1:0] Forward2;  // generate by forwarding unit

    // BranchAddr
    wire [31:0] BranchAddr;
    assign BranchAddr = ID_EX_PCplus4 + (ID_EX_immext << 2);

    // Operand1
    wire [31:0] Operand1;
    wire [31:0] EX_MEM_ALUout;
    wire [31:0] RegWriteData;
    assign Operand1 = ID_EX_ALUSrc1 ? {27'b0, ID_EX_shamt} : 
                    Forward1 == 1'b0 ? ID_EX_RegReadData1 :
                    Forward1 == 1'b1 ? EX_MEM_ALUout : RegWriteData;
    
    // Operand2_before_ALUSrc2
    wire [31:0] Operand2_before_ALUSrc2;
    assign Operand2_before_ALUSrc2 = Forward2 == 1'b0 ? ID_EX_RegReadData2 :
                                    Forward2 == 1'b1 ? EX_MEM_ALUout : RegWriteData;
    
    // Operand2
    wire [31:0] Operand2;
    assign Operand2 = ID_EX_ALUSrc2 ? ID_EX_immext:Operand2_before_ALUSrc2;
    
    // ALU
    wire [31:0] ALUout;
    ALU MyALU(reset, ID_EX_ALUOp, ID_EX_Sign, Operand1, Operand2, ALUout);

    // RegWriteAddr
    wire [4:0] RegWriteAddr;
    assign RegWriteAddr = ID_EX_RegDst == 1'b0 ? ID_EX_rd :
                        ID_EX_RegDst == 1'b1 ? ID_EX_rt : 5'd31;
    
    /* EX/MEM */
    wire EX_MEM_RegWrite;
    wire [1:0] EX_MEM_MemtoReg;
    wire EX_MEM_MemRead;
    wire EX_MEM_MemWrite;
    wire [4:0] EX_MEM_rt;
    wire [31:0] EX_MEM_PCplus4;
    wire [31:0] EX_MEM_Operand2_before_ALUSrc2;
    // wire [31:0] EX_MEM_ALUout,
    wire [4:0] EX_MEM_RegWriteAddr;
    EX_MEM MyEX_MEM(reset, clk, ID_EX_RegWrite, ID_EX_MemtoReg, ID_EX_MemRead, 
    ID_EX_MemWrite, ID_EX_rt, ID_EX_PCplus4, Operand2_before_ALUSrc2, ALUout, 
    RegWriteAddr, EX_MEM_RegWrite, EX_MEM_MemtoReg, EX_MEM_MemRead, EX_MEM_MemWrite, 
    EX_MEM_rt, EX_MEM_PCplus4, EX_MEM_Operand2_before_ALUSrc2, EX_MEM_ALUout, EX_MEM_RegWriteAddr);

    /* MEM */
    wire ForwardCopy;

    // MemWriteData
    wire [31:0] MemWriteData;
    assign MemWriteData = ForwardCopy ? RegWriteData : EX_MEM_Operand2_before_ALUSrc2;

    // DataMemory
    wire [31:0] MemReadData;
    wire [7:0] leds;
    wire [3:0] AN_wire;
    wire [7:0] BCD_wire;
    DataMemory MyDataMemory(reset, clk, EX_MEM_ALUout, MemWriteData, MemReadData, EX_MEM_MemRead, EX_MEM_MemWrite, AN_wire, BCD_wire, leds);
    
    always@* begin
        AN <= AN_wire;
        BCD <= BCD_wire;
    end

    /* MEM/WB */
    wire MEM_WB_RegWrite;
    wire [1:0] MEM_WB_MemtoReg;
    wire [31:0] MEM_WB_PCplus4;
    wire [31:0] MEM_WB_ALUout;
    wire [4:0] MEM_WB_RegWriteAddr;
    wire [31:0] MEM_WB_MemReadData;
    MEM_WB MyMEM_WB(reset, clk, EX_MEM_RegWrite, EX_MEM_MemtoReg, EX_MEM_PCplus4, 
    EX_MEM_ALUout, EX_MEM_RegWriteAddr, MemReadData, MEM_WB_RegWrite, MEM_WB_MemtoReg, 
    MEM_WB_PCplus4, MEM_WB_ALUout, MEM_WB_RegWriteAddr, MEM_WB_MemReadData);

    /* WB */
    // RegWriteData
    assign RegWriteData = MEM_WB_MemtoReg == 1'b0 ? MEM_WB_ALUout : 
                        MEM_WB_MemtoReg == 1'b1 ? MEM_WB_MemReadData : MEM_WB_PCplus4;

    // RegisterFile
    wire [31:0] v0;
    RegisterFile MyRegisterFile(reset, clk, MEM_WB_RegWrite, rs, rt, MEM_WB_RegWriteAddr, RegWriteData, RegReadData1, RegReadData2, v0);

    /* PC */
    wire PCCont;
    wire [31:0] BranchTarget;
    wire [31:0] pc;
    PC MyPC(reset, clk, PCSrc, ID_EX_PCSrc, PCCont, IF_ID_PCplus4, BranchTarget, target, RegReadData1, pc);

    /* IF */
    wire [31:0] PCplus4;
    assign PCplus4 = pc + 4;

    // InstructionMemory
    wire [31:0] Instruction;
    InstructionMemory MyInstructionMemory(pc, Instruction);

    /* IF/ID */
    wire IF_IDCont;
    IF_ID MyIF_ID(reset, clk, IF_IDCont, PCSrc, ID_EX_PCSrc, PCplus4, Instruction, IF_ID_PCplus4, IF_ID_Instruction);
                
    /* Other units */
    // Forwarding Unit
    ForwardingUnit MyForwardingUnit(reset, EX_MEM_RegWrite, MEM_WB_RegWrite, ID_EX_rs, ID_EX_rt, 
    EX_MEM_rt, EX_MEM_RegWriteAddr, MEM_WB_RegWriteAddr, Forward1, Forward2, ForwardCopy);

    // Hazard Unit
    HazardUnit MyHazardUnit(reset, ID_EX_MemRead, rt, rs, ID_EX_rt, PCCont, IF_IDCont, ID_EXCont);

    // Branch Unit
    BranchUnit MyBranchUnit(reset, ID_EX_BranchOp, ALUout, BranchAddr, ID_EX_PCplus4, BranchTarget);

    assign small_pc = v0[7:0];


endmodule