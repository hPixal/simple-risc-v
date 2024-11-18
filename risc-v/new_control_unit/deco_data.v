`include "../risc-v-defines.v"

module deco_data (
    // data control
    input wire [1:0] LS,
    input wire [2:0] funct3,

    // Output
    output wire [2:0] Data_T
    
);

reg [2:0] aux_data = 0;

always @(*) begin
    case (funct3)
        3'b000:
            begin
                if (LS == 2'b10) begin
                    aux_data = 3'b010;
                end else begin
                    aux_data = 3'b101;
                end
            end
        3'b001:
            begin
                if (LS == 2'b10) begin
                    aux_data = 3'b001;
                end else begin
                    aux_data = 3'b110;
                end
            end
        3'b010:
            begin
                if (LS == 2'b10) begin
                    aux_data = 3'b000;
                end else begin
                    aux_data = 3'b100;
                end
            end
        3'b100:
            begin
                aux_data = 3'b011;
            end
        3'b101:
            begin
                aux_data = 3'b111;
            end
        default:
            begin
                aux_data = 3'b000;
            end 
    endcase
end

assign Data_T = aux_data;

endmodule