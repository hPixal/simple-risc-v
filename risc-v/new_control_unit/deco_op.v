`include "../risc-v-defines.v"

module deco_op (
    // Deco input
    input wire RI,
    input wire [2:0] funct3,
    input wire [6:0] funct7,

    // Multiplex input
    input wire [4:0] in_shamt,
    input wire [4:0] RD2,
    // input zero = 5'b0000
    
    // Output
    output wire [3:0] alu_op,
    output wire [4:0] SHAMT
);

// Auxiliares
reg [1:0] aux_S = 0;
reg [3:0] aux_alu_op = 0;
reg [4:0] aux_SHAMT = 0;

always @(*) begin
    case (funct7)
        7'b0100000:
            begin
                case (funct3)
                    `FUNCT3_SUB:
                        begin
                            aux_alu_op = 4'b0010;
                            aux_S = 2'b00;
                        end
                    `FUNCT3_SRA:
                        begin
                            aux_alu_op = 4'b1000;
                            if (RI == 3'b001) begin
                                aux_S = 2'b10;
                            end else begin
                                aux_S = 2'b11;
                            end
                        end
                endcase
            end
        7'b0000000:
            begin
                case (funct3)
                    `FUNCT3_ADD:
                        begin
                            aux_alu_op = 4'b0001;
                            aux_S = 2'b00;
                        end
                    `FUNCT3_SLL:
                        begin
                            aux_alu_op = 4'b0110;
                            if (RI == 3'b001) begin
                                aux_S = 2'b10;
                            end else begin
                                aux_S = 2'b11;
                            end
                        end
                    `FUNCT3_XOR:
                        begin
                            aux_alu_op = 4'b0101;
                            aux_S = 2'b00;
                        end
                    `FUNCT3_SRL:
                        begin
                            aux_alu_op = 4'b0111;
                            if (RI == 3'b001) begin
                                aux_S = 2'b10;
                            end else begin
                                aux_S = 2'b11;
                            end
                        end
                    `FUNCT3_OR:
                        begin
                            aux_alu_op = 4'b0100;
                            aux_S = 2'b00;
                        end
                    `FUNCT3_AND:
                        begin
                            aux_alu_op = 4'b0011;
                            aux_S = 2'b00;
                        end
                endcase
            end
        default:
            begin
                aux_S = 2'b00;
                case (funct3)
                    3'b000:
                        begin
                            if (RI == 2'b110) begin
                                aux_alu_op = 4'b0001;
                            end else begin
                                aux_alu_op = 4'b1111;
                            end
                        end
                    3'b001:
                        begin
                            if (RI == 2'b110) begin
                                aux_alu_op = 4'b0001;
                            end else begin
                                aux_alu_op = 4'b1111;
                            end
                        end
                    3'b010:
                        begin
                            aux_alu_op = 4'b0001;
                        end
                    3'b100:
                        begin
                            if (RI == 2'b110) begin
                                aux_alu_op = 4'b0001;
                            end else begin
                                aux_alu_op = 4'b1111;
                            end
                        end
                    3'b101:
                        begin
                            if (RI == 2'b110) begin
                                aux_alu_op = 4'b0001;
                            end else begin
                                aux_alu_op = 4'b1111;
                            end
                        end
                    3'b110:
                        begin
                            aux_alu_op = 4'b0010;
                        end
                    3'b111:
                        begin
                            aux_alu_op = 4'b0010;
                        end
                    default:
                        begin
                            aux_alu_op = 4'b0000;
                        end
                endcase
            end
    endcase
    case (aux_S)
        2'b10:
            begin
                aux_SHAMT = RD2;
            end
        2'b11:
            begin
                aux_SHAMT = in_shamt;
            end
        default:
            begin
                aux_SHAMT = 5'b00000;
            end
    endcase 
end

assign SHAMT = aux_SHAMT;
assign alu_op = aux_alu_op;

endmodule