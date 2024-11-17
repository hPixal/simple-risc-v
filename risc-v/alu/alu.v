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
        case (op)
            `ALU_ADD: begin
                out_s = in_a + in_b; // Addition
            end
            `ALU_SUB: begin
                out_s = in_a - in_b; // Subtraction
            end
            `ALU_AND: begin
                out_s = in_a & in_b; // Logical AND
            end
            `ALU_OR: begin
                out_s = in_a | in_b; // Logical OR
            end
            `ALU_XOR: begin
                out_s = in_a ^ in_b; // Logical XOR
            end
            `ALU_SLL: begin
                out_s = in_a << in_b[4:0]; // Shift left logical
            end
            `ALU_SRL: begin
                out_s = in_a >> in_b[4:0]; // Shift right logical
            end
            `ALU_SRA: begin
                out_s = $signed(in_a) >>> in_b[4:0]; // Shift right arithmetic
            end
            default: begin
                out_s = 32'b0; // Default to zero
            end
        endcase
    end
end

endmodule
