`include "../risc-v-defines.v"

module imm_gen (
    input wire clk,         // Clock input
    input wire rst,         // Reset input
    input wire [31:0] inst, // Instruction input
    output reg [31:0] imm   // Immediate output
);

always @ (posedge clk) begin
    if (rst == 1'b1) begin
        imm <= 32'b0;
    end
    else begin
        case(inst[6:0])
                `OP_I_TYPE: imm <= {{20{inst[31]}}, inst[31:20]};
                `OP_S_TYPE: imm <= {{20{inst[31]}}, inst[31:25], inst[11:7]};
                `OP_B_TYPE: imm <= {{19{inst[31]}}, inst[7], inst[30:25], inst[11:8]};
                `OP_U_TYPE: imm <= {inst[31:12], 12'b0};
                `OP_J_TYPE: imm <= {{12{inst[31]}}, inst[19:12], inst[20], inst[30:21]};
            default: 
                imm <= 32'b0;
        endcase
    end
end

endmodule
