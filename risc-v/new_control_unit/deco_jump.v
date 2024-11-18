`include "../risc-v-defines.v"

module deco_jump(
    // jump control
    input wire rst,
    input wire [2:0] BJ,
    input wire EXC,
    input wire [2:0] funct3,

    // deco2
    input wire flags,

    // Output
    output wire Reg,
    output wire [1:0] jump,
    output wire Branch
);

reg aux_reg = 0;
reg aux_B = 0;
reg [1:0] aux_jump;
reg aux_branch = 0;

always @(*) begin
    if (rst == 1'b1) begin
        aux_reg = 0;
        aux_jump = 2'b00;
        aux_B = 0;
    end if (EXC == 1'b1) begin
        aux_reg = 0;
        aux_jump = 2'b11;
        aux_B = 0;
    end else begin
        case (funct3)
            3'b000:
                begin
                    if (BJ == 3'b001) begin
                        aux_B = 1;
                        aux_reg = 0;
                        aux_jump = 2'b01;
                    end else begin
                        aux_B = 0;
                        aux_reg = 1;
                        aux_jump = 2'b10;
                    end
                end
            3'b001:
                begin
                    aux_B = 1;
                    aux_reg = 0;
                    aux_jump = 2'b01;
                end
            3'b100:
                begin
                    aux_B = 1;
                    aux_reg = 0;
                    aux_jump = 2'b01;
                end
            3'b101:
                begin
                    aux_B = 1;
                    aux_reg = 0;
                    aux_jump = 2'b01;
                end
            3'b110:
                begin
                    aux_B = 1;
                    aux_reg = 0;
                    aux_jump = 2'b01;
                end
            3'b111:
                begin
                    aux_B = 1;
                    aux_reg = 0;
                    aux_jump = 2'b01;
                end
            default:
                begin
                    case (BJ)
                        3'b100:
                            begin
                                aux_B = 0;
                                aux_reg = 0;
                                aux_jump = 2'b10;
                            end
                        3'b010:
                            begin
                                aux_B = 0;
                                aux_reg = 0;
                                aux_jump = 2'b10;
                            end
                        3'b000:
                            begin
                                aux_B = 0;
                                aux_reg = 0;
                                aux_jump = 2'b01;
                            end
                        default:
                            begin
                                aux_B = 0;
                                aux_reg = 0;
                                aux_jump = 2'b00;
                            end
                    endcase
                end
        endcase
    end
end

assign Branch = aux_B;
assign Reg = aux_reg;
assign jump = aux_jump;

endmodule