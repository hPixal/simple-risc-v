`include "../risc-v-defines.v"

module control_unit (
    input wire [6:0] opcode,   // Opcode from the instruction
    input wire [2:0] funct3,   // funct3 field from the instruction
    input wire [6:0] funct7,   // funct7 field from the instruction
    input wire zero,           // Zero flag for branches
    output reg reg_write,      // Register write enable
    output reg alu_src,        // ALU source select
    output reg mem_write,      // Memory write enable
    output reg mem_read,       // Memory read enable
    output reg mem_to_reg,     // Memory to register select
    output reg branch,         // Branch enable
    output reg jump,           // Jump enable
    output reg [2:0] alu_op    // ALU operation
);

    always @(*) begin
        // Default values for all outputs
        reg_write = 0;
        alu_src = 0;
        mem_write = 0;
        mem_read = 0;
        mem_to_reg = 0;
        branch = 0;
        jump = 0;
        alu_op = 3'b000; // Default ALU operation (add)

        case (opcode)
            `OPCODE_R: begin // R-Type
                reg_write = 1;
                alu_src = 0;
                alu_op = funct3; // ALU operation depends on funct3/funct7
            end
            `OPCODE_I: begin // I-Type (ALU)
                reg_write = 1;
                alu_src = 1;
                alu_op = funct3;
            end
            `OPCODE_LOAD: begin // Load
                reg_write = 1;
                mem_read = 1;
                mem_to_reg = 1;
                alu_src = 1;
            end
            `OPCODE_STORE: begin // Store
                mem_write = 1;
                alu_src = 1;
            end
            `OPCODE_BRANCH: begin // Branch
                branch = 1;
                alu_op = 3'b001; // Subtract for branch comparison
            end
            `OPCODE_JAL: begin // JAL
                jump = 1;
                reg_write = 1;
            end
            `OPCODE_JALR: begin // JALR
                jump = 1;
                reg_write = 1;
                alu_src = 1;
            end
            `OPCODE_LUI: begin // LUI
                reg_write = 1;
                alu_src = 1;
                alu_op = 3'b010; // Custom ALU op for LUI
            end
            `OPCODE_AUIPC: begin // AUIPC
                reg_write = 1;
                alu_src = 1;
                alu_op = 3'b011; // Custom ALU op for AUIPC
            end
        endcase
    end
endmodule
