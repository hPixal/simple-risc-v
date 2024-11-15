`include "../risc-v-defines.v"

module alu (
    input wire clk,           // Clock input
    input wire rst,           // Reset input
    input wire [3:0] op,      // Operation code
    input wire [31:0] in_a,   // Operand A
    input wire [31:0] in_b,   // Operand B
    output reg [31:0] out_s   // Result
);

always @ (posedge clk) begin
    if (rst == 1'b1) begin
        out_s <= 32'b0;       // Reset the output
    end
    else begin
        case(op)
            `ALU_ADD    :       out_s = in_a + in_b;
            `ALU_SUB    :       out_s = in_a - in_b;
            `ALU_SLL    :       out_s = in_a << in_b[4:0];
            `ALU_SRL    :       out_s = in_a >> in_b[4:0];
            `ALU_SRA    :       out_s = $signed(in_a) >>> in_b[4:0];
            `ALU_SLT    :       out_s = ($signed(in_a) < $signed(in_b)) ? 32'h1 : 32'h0;
            `ALU_SLTU   :       out_s = (in_a < in_b) ? 32'h1 : 32'h0;
            `ALU_XOR    :       out_s = in_a ^ in_b;
            `ALU_OR     :       out_s = in_a | in_b;
            `ALU_AND    :       out_s = in_a & in_b;
            `ALU_PASS_B :       out_s = in_b;
            default     :       out_s = 32'h0; // Default for invalid operations
        endcase
    end
end

endmodule
