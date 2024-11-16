`include "../risc-v-defines.v"

module imm_gen (
    input wire [31:0] instr, // Full instr word
    input wire [2:0] imm_sel,      // Immediate select signal
    output reg [31:0] imm_out      // Generated immediate value
);

    always @(*) begin
        case (imm_sel)
            `IMM_I: begin // I-type immediate
                imm_out = {{20{instr[31]}}, instr[31:20]};
            end
            `IMM_S: begin // S-type immediate
                imm_out = {{20{instr[31]}}, instr[31:25], instr[11:7]};
            end
            `IMM_B: begin // B-type immediate
                imm_out = {{19{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0};
            end
            `IMM_U: begin // U-type immediate
                imm_out = {instr[31:12], 12'b0};
            end
            `IMM_J: begin // J-type immediate
                imm_out = {{11{instr[31]}}, instr[31], instr[19:12], instr[20], instr[30:21], 1'b0};
            end
            default: begin // Default: 0
                imm_out = 32'b0;
            end
        endcase
    end
endmodule
