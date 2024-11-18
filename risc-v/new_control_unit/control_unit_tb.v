`timescale 1ns / 1ps

module control_unit_tb;

    // Inputs
    reg clk;
    reg rst;
    reg [6:0] opcode;
    reg [2:0] funct3;
    reg [6:0] funct7;
    reg [4:0] in_shamt;
    reg [4:0] RD2;
    reg flags;

    // Outputs
    wire [1:0] Data_S;
    wire Reg_W;
    wire ALU_S;
    wire Mem_W;
    wire Mem_R;
    wire [3:0] alu_op;
    wire [4:0] SHAMT;
    wire [2:0] Data_T;
    wire Reg;
    wire [1:0] jump;
    wire Branch;

    // Instantiate the control_unit
    control_unit uut (
        .clk(clk),
        .rst(rst),
        .opcode(opcode),
        .funct3(funct3),
        .funct7(funct7),
        .in_shamt(in_shamt),
        .RD2(RD2),
        .flags(flags),
        .Data_S(Data_S),
        .Reg_W(Reg_W),
        .ALU_S(ALU_S),
        .Mem_W(Mem_W),
        .Mem_R(Mem_R),
        .alu_op(alu_op),
        .SHAMT(SHAMT),
        .Data_T(Data_T),
        .Reg(Reg),
        .jump(jump),
        .Branch(Branch)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;  // 100 MHz clock
    end

    // Stimulus block
    initial begin
        $dumpfile("control_unit_tb.vcd");
        $dumpvars(0, control_unit_tb);
        // Initialize inputs
        clk = 0;
        rst = 0;
        opcode = 7'b0;
        funct3 = 3'b0;
        funct7 = 7'b0;
        in_shamt = 5'b0;
        RD2 = 5'b0;
        flags = 0;

        // Apply reset
        rst = 0;
        #10;
        rst = 0;

        // Test case 1: R-type instruction
        opcode = 7'b0110011;  // R-type opcode (ADD, SUB, etc.)
        funct3 = 3'b000;      // ADD
        funct7 = 7'b0000000;  // Normal funct7 for ADD
        in_shamt = 5'b0;
        RD2 = 5'b0;
        flags = 0;
        #10;

        // Test case 2: I-type instruction (e.g., ADDI)
        opcode = 7'b0010011;  // I-type opcode (ADDI, etc.)
        funct3 = 3'b000;      // ADDI
        funct7 = 7'b0000000;  // No funct7 for I-type
        in_shamt = 5'b0;
        RD2 = 5'b0;
        flags = 0;
        #10;

        // Test case 3: Branch instruction (BEQ)
        opcode = 7'b1100011;  // Branch opcode (BEQ, etc.)
        funct3 = 3'b000;      // BEQ
        funct7 = 7'b0000000;  // No funct7 for BEQ
        in_shamt = 5'b0;
        RD2 = 5'b0;
        flags = 1;            // Condition met for branch
        #10;

        // Test case 4: Load instruction (LW)
        opcode = 7'b0000011;  // Load opcode (LW, etc.)
        funct3 = 3'b010;      // LW
        funct7 = 7'b0000000;  // No funct7 for LW
        in_shamt = 5'b0;
        RD2 = 5'b0;
        flags = 0;
        #10;

        // Test case 5: Store instruction (SW)
        opcode = 7'b0100011;  // Store opcode (SW, etc.)
        funct3 = 3'b010;      // SW
        funct7 = 7'b0000000;  // No funct7 for SW
        in_shamt = 5'b0;
        RD2 = 5'b0;
        flags = 0;
        #10;

        // Test case 6: Jump instruction (JAL)
        opcode = 7'b1101111;  // Jump opcode (JAL, etc.)
        funct3 = 3'b000;      // JAL
        funct7 = 7'b0000000;  // No funct7 for JAL
        in_shamt = 5'b0;
        RD2 = 5'b0;
        flags = 0;
        #10;

        // Test case 7: Load upper immediate (LUI)
        opcode = 7'b0110111;  // LUI opcode
        funct3 = 3'b000;      // LUI
        funct7 = 7'b0000000;  // No funct7 for LUI
        in_shamt = 5'b0;
        RD2 = 5'b0;
        flags = 0;
        #10;

        // Test case 8: AUIPC (Add Upper Immediate to PC)
        opcode = 7'b0010111;  // AUIPC opcode
        funct3 = 3'b000;      // AUIPC
        funct7 = 7'b0000000;  // No funct7 for AUIPC
        in_shamt = 5'b0;
        RD2 = 5'b0;
        flags = 0;
        #10;

        // Finish the simulation
        $finish;
    end

    // Monitor the outputs
    initial begin
        $monitor("Time = %0d, Opcode = %b, Data_S = %b, Reg_W = %b, ALU_S = %b, Mem_W = %b, Mem_R = %b, alu_op = %b, SHAMT = %b, Data_T = %b, Reg = %b, jump = %b, Branch = %b",
                 $time, opcode, Data_S, Reg_W, ALU_S, Mem_W, Mem_R, alu_op, SHAMT, Data_T, Reg, jump, Branch);
    end

endmodule
