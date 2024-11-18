`include "../risc-v-defines.v"

module control_principal (
    // Main control
    input wire clk,
    input wire rst,
    input wire [6:0] opcode,   // Opcode from the instruction

    // Internal signals
    output wire [2:0] RI,
    output wire [1:0] LS,
    output wire [2:0] BJ,
    output wire EXC,
    
    // Pass
    output wire CLK,
    output wire RST,
    
    // Output
    output wire [1:0] Data_S,
    output wire Reg_W,
    output wire ALU_S,
    output wire Mem_W,
    output wire Mem_R
    
);

// Auxiliares para operar
reg [2:0] aux_RI = 0;
reg [1:0] aux_LS = 0;
reg [2:0] aux_BJ = 0;
reg aux_EXC = 0;
reg [1:0] aux_Data_S = 0;
reg aux_Reg_W = 0;
reg aux_ALU_S = 0;
reg aux_Mem_W = 0;
reg aux_Mem_R = 0;

always @(posedge clk) begin
    case (opcode)
        `OPCODE_R:
            begin
                aux_RI = 3'b001;
                aux_LS = 2'b00;
                aux_BJ = 3'b000;
                aux_EXC = 0;
                aux_Data_S = 2'b00;
                aux_Reg_W = 1;
                aux_ALU_S = 0;
                aux_Mem_W = 0;
                aux_Mem_R = 0;
            end
        `OPCODE_I:
            begin
                aux_RI = 3'b010;
                aux_LS = 2'b00;
                aux_BJ = 3'b000;
                aux_EXC = 0;
                aux_Data_S = 2'b00;
                aux_Reg_W = 1;
                aux_ALU_S = 1;
                aux_Mem_W = 0;
                aux_Mem_R = 0;
            end
        `OPCODE_LOAD:
            begin
                aux_RI = 3'b110;
                aux_LS = 2'b10;
                aux_BJ = 3'b000;
                aux_EXC = 0;
                aux_Data_S = 2'b01;
                aux_Reg_W = 1;
                aux_ALU_S = 1;
                aux_Mem_W = 0;
                aux_Mem_R = 1;
            end
        `OPCODE_STORE:
            begin
                aux_RI = 3'b110;
                aux_LS = 2'b01;
                aux_BJ = 3'b000;
                aux_EXC = 0;
                aux_Data_S = 2'b01;
                aux_Reg_W = 0;
                aux_ALU_S = 1;
                aux_Mem_W = 1;
                aux_Mem_R = 0;
            end
        `OPCODE_BRANCH:
            begin
                aux_RI = 3'b101;
                aux_LS = 2'b00;
                aux_BJ = 3'b001;
                aux_EXC = 0;
                aux_Data_S = 2'b00;
                aux_Reg_W = 0;
                aux_ALU_S = 0;
                aux_Mem_W = 0;
                aux_Mem_R = 0;
            end
        `OPCODE_JALR:
            begin
                aux_RI = 3'b000;
                aux_LS = 2'b00;
                aux_BJ = 3'b101;
                aux_EXC = 0;
                aux_Data_S = 2'b11;
                aux_Reg_W = 1;
                aux_ALU_S = 0;
                aux_Mem_W = 0;
                aux_Mem_R = 0;
            end
        `OPCODE_JAL:
            begin
                aux_RI = 3'b000;
                aux_LS = 2'b00;
                aux_BJ = 3'b100;
                aux_EXC = 0;
                aux_Data_S = 2'b11;
                aux_Reg_W = 1;
                aux_ALU_S = 0;
                aux_Mem_W = 0;
                aux_Mem_R = 0;
            end
        `OPCODE_AUIPC:
            begin
                aux_RI = 3'b000;
                aux_LS = 2'b00;
                aux_BJ = 3'b010;
                aux_EXC = 0;
                aux_Data_S = 2'b00;
                aux_Reg_W = 0;
                aux_ALU_S = 0;
                aux_Mem_W = 0;
                aux_Mem_R = 0;
            end
        `OPCODE_LUI:
            begin
                aux_RI = 3'b000;
                aux_LS = 2'b00;
                aux_BJ = 3'b000;
                aux_EXC = 0;
                aux_Data_S = 2'b10;
                aux_Reg_W = 1;
                aux_ALU_S = 0;
                aux_Mem_W = 0;
                aux_Mem_R = 0;
            end
        default:
            begin
                aux_RI = 3'b000;
                aux_LS = 2'b00;
                aux_BJ = 3'b000;
                aux_EXC = 1;
                aux_Data_S = 2'b00;
                aux_Reg_W = 0;
                aux_ALU_S = 0;
                aux_Mem_W = 0;
                aux_Mem_R = 0;
            end
    endcase

end

assign RI = aux_RI;
assign LS = aux_LS;
assign BJ = aux_BJ;
assign EXC = aux_EXC;
assign Data_S = aux_Data_S;
assign Reg_W = aux_Reg_W;
assign ALU_S = aux_ALU_S;
assign Mem_W = aux_Mem_W;
assign Mem_R = aux_Mem_R;

endmodule