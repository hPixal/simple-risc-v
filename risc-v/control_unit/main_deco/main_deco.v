module MainDecoder (
    input [31:0] instruction,   // Full 32-bit instruction
    output reg [3:0] alu_op,    // ALU operation selection
    output reg [2:0] imm_gen,   // Immediate generator selection
    output reg [1:0] pc_sel,    // PC selection
    output reg [1:0] alu_a_sel, // ALU A operand select
    output reg [1:0] alu_b_sel, // ALU B operand select
    output reg [1:0] wb_sel,    // Writeback select
    output reg [1:0] br_sel,    // Branch select
    output reg dmem_write       // Data memory write enable
);

    wire [6:0] opcode = instruction[6:0];     // Extract opcode
    wire [2:0] funct3 = instruction[14:12];   // Extract funct3
    wire [6:0] funct7 = instruction[31:25];   // Extract funct7

    always @(*) begin
        // Default values for control signals
        alu_op     = `ALU_PASS_B;
        imm_gen    = `IG_DISABLED;
        pc_sel     = `PC_SEL_INC4;
        alu_a_sel  = `ALU_A_SEL_PC;
        alu_b_sel  = `ALU_B_SEL_RS2;
        wb_sel     = `WB_SEL_ALU;
        br_sel     = `BR_SEL_BEQ;
        dmem_write = 0;

        case (opcode)
            `OP_R_TYPE: begin
                pc_sel = `PC_SEL_INC4;
                imm_gen = `IG_DISABLED;
                alu_a_sel = `ALU_A_SEL_RS1;
                alu_b_sel = `ALU_B_SEL_RS2;
                wb_sel = `WB_SEL_ALU;

                // ALU operation based on funct3 and funct7
                case ({funct7, funct3})
                    {7'b0000000, 3'b000}: alu_op = `ALU_ADD;
                    {7'b0100000, 3'b000}: alu_op = `ALU_SUB;
                    {7'b0000000, 3'b001}: alu_op = `ALU_SLL;
                    {7'b0000000, 3'b101}: alu_op = `ALU_SRL;
                    {7'b0100000, 3'b101}: alu_op = `ALU_SRA;
                    {7'b0000000, 3'b010}: alu_op = `ALU_SLT;
                    {7'b0000000, 3'b011}: alu_op = `ALU_SLTU;
                    {7'b0000000, 3'b100}: alu_op = `ALU_XOR;
                    {7'b0000000, 3'b110}: alu_op = `ALU_OR;
                    {7'b0000000, 3'b111}: alu_op = `ALU_AND;
                    default: alu_op = `ALU_PASS_B;
                endcase
            end

            `OP_I_TYPE: begin
                pc_sel = `PC_SEL_INC4;
                imm_gen = `IG_I_TYPE;
                alu_a_sel = `ALU_A_SEL_RS1;
                alu_b_sel = `ALU_B_SEL_IMM;
                wb_sel = `WB_SEL_ALU;

                case (funct3)
                    3'b000: alu_op = `ALU_ADD;  // ADDI
                    3'b010: alu_op = `ALU_SLT;  // SLTI
                    3'b011: alu_op = `ALU_SLTU; // SLTIU
                    3'b100: alu_op = `ALU_XOR;  // XORI
                    3'b110: alu_op = `ALU_OR;   // ORI
                    3'b111: alu_op = `ALU_AND;  // ANDI
                    default: alu_op = `ALU_PASS_B;
                endcase
            end

            `OP_B_TYPE: begin
                pc_sel = `PC_SEL_ALU;
                imm_gen = `IG_B_TYPE;
                alu_a_sel = `ALU_A_SEL_PC;
                alu_b_sel = `ALU_B_SEL_IMM;
                wb_sel = `WB_SEL_INC4;

                // Branch selection based on funct3
                case (funct3)
                    3'b000: br_sel = `BR_SEL_BEQ; // BEQ
                    3'b001: br_sel = `BR_SEL_BNE; // BNE
                    3'b100: br_sel = `BR_SEL_BLT; // BLT
                    3'b101: br_sel = `BR_SEL_BGE; // BGE
                    default: br_sel = `BR_SEL_BEQ;
                endcase
            end

            `OP_S_TYPE: begin
                pc_sel = `PC_SEL_INC4;
                imm_gen = `IG_S_TYPE;
                alu_a_sel = `ALU_A_SEL_RS1;
                alu_b_sel = `ALU_B_SEL_IMM;
                wb_sel = `WB_SEL_ALU;
                dmem_write = 1; // Enable memory write
            end

            `OP_U_TYPE: begin
                pc_sel = `PC_SEL_INC4;
                imm_gen = `IG_U_TYPE;
                alu_a_sel = `ALU_A_SEL_PC;
                alu_b_sel = `ALU_B_SEL_IMM;
                wb_sel = `WB_SEL_ALU;
            end

            `OP_J_TYPE: begin
                pc_sel = `PC_SEL_ALU;
                imm_gen = `IG_J_TYPE;
                alu_a_sel = `ALU_A_SEL_PC;
                alu_b_sel = `ALU_B_SEL_IMM;
                wb_sel = `WB_SEL_INC4;
            end

            default: begin
                // Set control signals to default safe values
                alu_op     = `ALU_PASS_B;
                imm_gen    = `IG_DISABLED;
                pc_sel     = `PC_SEL_INC4;
                alu_a_sel  = `ALU_A_SEL_PC;
                alu_b_sel  = `ALU_B_SEL_RS2;
                wb_sel     = `WB_SEL_ALU;
                br_sel     = `BR_SEL_BEQ;
                dmem_write = 0;
            end
        endcase
    end
endmodule
