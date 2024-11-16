`timescale 1ns/1ps
`include "../risc-v-defines.v"

module control_unit_tb;

    // Testbench signals
    reg [6:0] opcode;
    reg [2:0] funct3;
    reg [6:0] funct7;
    reg zero;
    wire reg_write;
    wire alu_src;
    wire mem_write;
    wire mem_read;
    wire mem_to_reg;
    wire branch;
    wire jump;
    wire [2:0] alu_op;

    // Instantiate the control unit
    control_unit uut (
        .opcode(opcode),
        .funct3(funct3),
        .funct7(funct7),
        .zero(zero),
        .reg_write(reg_write),
        .alu_src(alu_src),
        .mem_write(mem_write),
        .mem_read(mem_read),
        .mem_to_reg(mem_to_reg),
        .branch(branch),
        .jump(jump),
        .alu_op(alu_op)
    );

    // Test procedure
    initial begin
        $dumpfile("control_unit_tb.vcd");
        $dumpvars(0, control_unit_tb);

        // Test R-type instruction
        opcode = `OPCODE_R; funct3 = 3'b000; funct7 = 7'b0000000; zero = 0;
        #10; // Wait 10 ns
        $display("R-Type | reg_write=%b alu_src=%b mem_write=%b mem_read=%b mem_to_reg=%b branch=%b jump=%b alu_op=%b",
                 reg_write, alu_src, mem_write, mem_read, mem_to_reg, branch, jump, alu_op);

        // Test I-type instruction
        opcode = `OPCODE_I; funct3 = 3'b010; funct7 = 7'b0000000; zero = 0;
        #10;
        $display("I-Type | reg_write=%b alu_src=%b mem_write=%b mem_read=%b mem_to_reg=%b branch=%b jump=%b alu_op=%b",
                 reg_write, alu_src, mem_write, mem_read, mem_to_reg, branch, jump, alu_op);

        // Test Load instruction
        opcode = `OPCODE_LOAD; funct3 = 3'b000; funct7 = 7'b0000000; zero = 0;
        #10;
        $display("Load   | reg_write=%b alu_src=%b mem_write=%b mem_read=%b mem_to_reg=%b branch=%b jump=%b alu_op=%b",
                 reg_write, alu_src, mem_write, mem_read, mem_to_reg, branch, jump, alu_op);

        // Test Store instruction
        opcode = `OPCODE_STORE; funct3 = 3'b010; funct7 = 7'b0000000; zero = 0;
        #10;
        $display("Store  | reg_write=%b alu_src=%b mem_write=%b mem_read=%b mem_to_reg=%b branch=%b jump=%b alu_op=%b",
                 reg_write, alu_src, mem_write, mem_read, mem_to_reg, branch, jump, alu_op);

        // Test Branch instruction
        opcode = `OPCODE_BRANCH; funct3 = 3'b000; funct7 = 7'b0000000; zero = 1;
        #10;
        $display("Branch | reg_write=%b alu_src=%b mem_write=%b mem_read=%b mem_to_reg=%b branch=%b jump=%b alu_op=%b",
                 reg_write, alu_src, mem_write, mem_read, mem_to_reg, branch, jump, alu_op);

        // Test JAL instruction
        opcode = `OPCODE_JAL; funct3 = 3'b000; funct7 = 7'b0000000; zero = 0;
        #10;
        $display("JAL    | reg_write=%b alu_src=%b mem_write=%b mem_read=%b mem_to_reg=%b branch=%b jump=%b alu_op=%b",
                 reg_write, alu_src, mem_write, mem_read, mem_to_reg, branch, jump, alu_op);

        // Test JALR instruction
        opcode = `OPCODE_JALR; funct3 = 3'b000; funct7 = 7'b0000000; zero = 0;
        #10;
        $display("JALR   | reg_write=%b alu_src=%b mem_write=%b mem_read=%b mem_to_reg=%b branch=%b jump=%b alu_op=%b",
                 reg_write, alu_src, mem_write, mem_read, mem_to_reg, branch, jump, alu_op);

        // Test LUI instruction
        opcode = `OPCODE_LUI; funct3 = 3'b000; funct7 = 7'b0000000; zero = 0;
        #10;
        $display("LUI    | reg_write=%b alu_src=%b mem_write=%b mem_read=%b mem_to_reg=%b branch=%b jump=%b alu_op=%b",
                 reg_write, alu_src, mem_write, mem_read, mem_to_reg, branch, jump, alu_op);

        // Test AUIPC instruction
        opcode = `OPCODE_AUIPC; funct3 = 3'b000; funct7 = 7'b0000000; zero = 0;
        #10;
        $display("AUIPC  | reg_write=%b alu_src=%b mem_write=%b mem_read=%b mem_to_reg=%b branch=%b jump=%b alu_op=%b",
                 reg_write, alu_src, mem_write, mem_read, mem_to_reg, branch, jump, alu_op);

        $finish; // End simulation
    end
endmodule
