
module control_unit(
    /// control principal
    // Main control
    input wire clk,
    input wire rst,
    input wire [6:0] opcode,
    input wire [2:0] funct3,
    input wire [6:0] funct7,
    input wire [4:0] in_shamt,
    input wire [4:0] RD2,
    input wire flags,

    // Pass
    output wire CLK,
    output wire RESET,
    
    // Output
    output wire [1:0] Data_S,
    output wire Reg_W,
    output wire ALU_S,
    output wire Mem_W,
    output wire Mem_R,
    // Output
    output wire [3:0] alu_op,
    output wire [4:0] SHAMT,
    // Output
    output wire [2:0] Data_T,
    // Output
    output wire Reg,
    output wire [1:0] jump,
    output wire Branch

);

wire [2:0] RI;
wire [1:0] LS;
wire [2:0] BJ;
wire EXC;

// control principal
control_principal head (
    // Inputs
    .clk(clk),
    .rst(rst),
    .opcode(opcode),
    // Internal
    .RI(RI),
    .LS(LS),
    .BJ(BJ),
    .EXC(EXC),
    // Pass
    .CLK(CLK),
    .RST(RESET),
    // External
    .Data_S(Data_S),
    .Reg_W(Reg_W),
    .ALU_S(ALU_S),
    .Mem_W(Mem_W),
    .Mem_R(Mem_R)
);

// decodificador de alu
deco_op alu_deco(
    // Inputs
    .RI(RI),
    .funct3(funct3),
    .funct7(funct7),
    .in_shamt(in_shamt),
    .RD2(RD2),
    // Outputs
    .alu_op(alu_op),
    .SHAMT(SHAMT)
);

// decodificador de salto
deco_jump jump_deco(
    // Inputs
    .rst(rst),
    .BJ(BJ),
    .EXC(EXC),
    .funct3(funct3),
    .flags(flags),
    // Outputs
    .Reg(Reg),
    .jump(jump),
    .Branch(Branch)
);

// decodificador de data
deco_data data_deco(
    // Inputs
    .LS(LS),
    .funct3(funct3),
    // Outputs
    .Data_T(Data_T)
);

endmodule