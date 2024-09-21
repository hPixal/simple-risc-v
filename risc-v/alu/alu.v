`include "../risc-v-defines.v"

module imm_gen (
    input wire clk,         // Clock input
    input wire [3:0]  op,   // Reset input
    input wire [31:0] in_a, // Instruction input
    input wire [31:0] in_b, // Instruction input
    output reg [31:0] out_s // Immediate output
);

always @ (posedge clk) begin
    if (rst == 1'b1) begin
        imm <= 32'b0;
    end
    else begin
        case(op)
            `ALU_ADD:       out_s = in_a + in_b;
            `ALU_SUB:       out_s = in_a - in_b;
            `ALU_SLL:       out_s = in_a_double_sll[(63-shamt) -: 32];
            `ALU_SRL:       out_s = in_a_double_srl[shamt +: 32];
            `ALU_SRA:       out_s = in_a_double_sra[shamt +: 32];
            `ALU_SLT:       out_s = ($signed(in_a) < $signed(in_b)) ? 32'h1 : 32'h0;
            `ALU_SLTU:      out_s = (in_a < in_b) ? 32'h1 : 32'h0;
            `ALU_XOR:       out_s = in_a ^ in_b;
            `ALU_OR:        out_s = in_a | in_b;
            `ALU_AND:       out_s = in_a & in_b;
            `ALU_PASS_B:    out_s = in_b;
        default: out_s = 32'h0; // invalid operation

        endcase
    end
end

endmodule
