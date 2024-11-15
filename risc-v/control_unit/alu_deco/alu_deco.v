`include "../../risc-v-defines.v"

module alu_deco(
    input wire op,
    input wire f7,
    input wire [2:0] f3,
    input wire [1:0] aluOp,
    output wire [2:0] aluControl
);

reg [2:0] aluControlAux = `ALU_ADD; // Default to ADD operation

always @(*) begin
    case (aluOp)
        2'b00: aluControlAux = `ALU_ADD; // ADD for load/store operations
        2'b01: // Branch instructions
            case (f3)
                3'b000: aluControlAux = `ALU_BEQ; // BEQ
                3'b100: aluControlAux = `ALU_BLT; // BLT
                default: aluControlAux = `ALU_SUB; // Default to SUB
            endcase
        2'b10: // R-type instructions
            case (f3)
                3'b000: 
                    if (f7 && op)
                        aluControlAux = `ALU_SUB; // SUB if f7 is set and op is set
                    else 
                        aluControlAux = `ALU_ADD; // Otherwise ADD
                3'b010: aluControlAux = `ALU_SLT; // Set Less Than
                3'b110: aluControlAux = `ALU_OR;  // OR
                3'b111: aluControlAux = `ALU_AND; // AND
                default: aluControlAux = `ALU_ADD; // Default to ADD
            endcase
        default: aluControlAux = `ALU_ADD; // Default case
    endcase
end

assign aluControl = aluControlAux;

endmodule
