// Register file defines
`define NUM_REGISTERS 32
`define READ_X0_ZERO 5'b00000   // zero
`define READ_X1_RA 5'b00001     // return address
`define READ_X2_SP 5'b00010     // stack pointer 
`define READ_X3_GP 5'b00011     // global pointer
`define READ_X4_TP 5'b00100     // thread pointer
`define READ_X5_T0 5'b00101     // temporary/alternate link register
`define READ_X6_T1 5'b00110     // temporary
`define READ_X7_T2 5'b00111     // temporary
`define READ_X8_S0 5'b01000     // saved register/frame pointer
`define READ_X9_S1 5'b01001     // saved register
`define READ_X10_A0 5'b01010    // function argument/return value
`define READ_X11_A1 5'b01011    // function argument/return value
`define READ_X12_A2 5'b01100    // function argument
`define READ_X13_A3 5'b01101    // function argument
`define READ_X14_A4 5'b01110    // function argument
`define READ_X15_A5 5'b01111    // function argument
`define READ_X16_A6 5'b10000    // function argument
`define READ_X17_A7 5'b10001    // function argument
`define READ_X18_S2 5'b10010    // saved register
`define READ_X19_S3 5'b10011    // saved register
`define READ_X20_S4 5'b10100    // saved register
`define READ_X21_S5 5'b10101    // saved register
`define READ_X22_S6 5'b10110    // saved register
`define READ_X23_S7 5'b10111    // saved register
`define READ_X24_S8 5'b11000    // saved register
`define READ_X25_S9 5'b11001    // saved register
`define READ_X26_S10 5'b11010   // saved register
`define READ_X27_S11 5'b11011   // saved register
`define READ_X28_T3 5'b11100    // temporary
`define READ_X29_T4 5'b11101    // temporary
`define READ_X31_T6 5'b11110    // temporary
`define READ_X30_T5 5'b11111    // temporary


// Opcode defines
`define OP_R_TYPE 7'b0110011
`define OP_I_TYPE 7'b0010011
`define OP_S_TYPE 7'b0100011
`define OP_B_TYPE 7'b1100011
`define OP_U_TYPE 7'b0010111
`define OP_J_TYPE 7'b1101111

// ALU
`define ALU_ADD     4'b0000
`define ALU_SUB     4'b1000
`define ALU_SLL     4'b0001
`define ALU_SRL     4'b0101
`define ALU_SRA     4'b1101
`define ALU_SLT     4'b0010
`define ALU_SLTU    4'b0011
`define ALU_XOR     4'b0100
`define ALU_OR      4'b0110
`define ALU_AND     4'b0111
`define ALU_PASS_B  4'b1111

// Branch Resolution
`define BR_SEL_BEQ 2'd0 // Branch Equal
`define BR_SEL_BNE 2'd1 // Branch Not Equal
`define BR_SEL_BLT 2'd2 // Branch Less Than
`define BR_SEL_BGE 2'd3 // Branch Greater Than

`ifndef AMA_RISCV_DEFINES
`define AMA_RISCV_DEFINES

// Memory map
`define RESET_VECTOR 32'h8000_0000
`define DMEM_RANGE 2'b10
`define MMIO_RANGE 2'b01

// Opcodes
`define OPC7_R_TYPE 7'b011_0011 // R-type
`define OPC7_I_TYPE 7'b001_0011 // I-type
`define OPC7_LOAD 7'b000_0011 // I-type
`define OPC7_STORE 7'b010_0011 // S-type
`define OPC7_BRANCH 7'b110_0011 // B-type
`define OPC7_JALR 7'b110_0111 // I-type
`define OPC7_JAL 7'b110_1111 // J-type
`define OPC7_LUI 7'b011_0111 // U-type
`define OPC7_AUIPC 7'b001_0111 // U-type
`define OPC7_SYSTEM 7'b111_0011 // I-type, System

// NOP
`define NOP 32'h13 // addi x0 x0 0

// CSR addresses
`define CSR_TOHOST 12'h51E

// MUX select signals
// PC select
`define PC_SEL_INC4 2'd0 // PC = PC + 4
`define PC_SEL_ALU 2'd1 // ALU output, used for jump/branch
`define PC_SEL_BP 2'd2 // PC = Branch prediction output
`define PC_SEL_START_ADDR 2'd3 // PC = Hardwired start address

// ALU A operand select
`define ALU_A_SEL_RS1 2'd0 // A = Reg[rs1]
`define ALU_A_SEL_PC 2'd1 // A = PC
`define ALU_A_SEL_FWD_ALU 2'd2 // A = ALU; forwarding from MEM stage

// ALU B operand select
`define ALU_B_SEL_RS2 2'd0 // B = Reg[rs2]
`define ALU_B_SEL_IMM 2'd1 // B = Immediate value; from Imm Gen
`define ALU_B_SEL_FWD_ALU 2'd2 // B = ALU; forwarding from MEM stage

// Write back select
`define WB_SEL_DMEM 2'd0 // Reg[rd] = DMEM[ALU]
`define WB_SEL_ALU 2'd1 // Reg[rd] = ALU
`define WB_SEL_INC4 2'd2 // Reg[rd] = PC + 4
`define WB_SEL_CSR 2'd3 // Reg[rd] = CSR data

// Branch Resolution
`define BR_SEL_BEQ 2'd0 // Branch Equal
`define BR_SEL_BNE 2'd1 // Branch Not Equal
`define BR_SEL_BLT 2'd2 // Branch Less Than
`define BR_SEL_BGE 2'd3 // Branch Greater Than

// DMEM access
// DMEM Width
`define DMEM_BYTE   2'd0
`define DMEM_HALF   2'd1
`define DMEM_WORD   2'd2

// DMEM Offset
`define DMEM_OFF_0  2'd0
`define DMEM_OFF_1  2'd1
`define DMEM_OFF_2  2'd2
`define DMEM_OFF_3  2'd3

// Imm Gen
`define IG_DISABLED 3'b000
`define IG_I_TYPE   3'b001
`define IG_S_TYPE   3'b010
`define IG_B_TYPE   3'b011
`define IG_J_TYPE   3'b100
`define IG_U_TYPE   3'b101
