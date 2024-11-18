// Register file defines
`define NUM_REGISTERS   32
`define READ_X0_ZERO    5'b00000    // zero
`define READ_X1_RA      5'b00001    // return address
`define READ_X2_SP      5'b00010    // stack pointer 
`define READ_X3_GP      5'b00011    // global pointer
`define READ_X4_TP      5'b00100    // thread pointer
`define READ_X5_T0      5'b00101    // temporary/alternate link register
`define READ_X6_T1      5'b00110    // temporary
`define READ_X7_T2      5'b00111    // temporary
`define READ_X8_S0      5'b01000    // saved register/frame pointer
`define READ_X9_S1      5'b01001    // saved register
`define READ_X10_A0     5'b01010    // function argument/return value
`define READ_X11_A1     5'b01011    // function argument/return value
`define READ_X12_A2     5'b01100    // function argument
`define READ_X13_A3     5'b01101    // function argument
`define READ_X14_A4     5'b01110    // function argument
`define READ_X15_A5     5'b01111    // function argument
`define READ_X16_A6     5'b10000    // function argument
`define READ_X17_A7     5'b10001    // function argument
`define READ_X18_S2     5'b10010    // saved register
`define READ_X19_S3     5'b10011    // saved register
`define READ_X20_S4     5'b10100    // saved register
`define READ_X21_S5     5'b10101    // saved register
`define READ_X22_S6     5'b10110    // saved register
`define READ_X23_S7     5'b10111    // saved register
`define READ_X24_S8     5'b11000    // saved register
`define READ_X25_S9     5'b11001    // saved register
`define READ_X26_S10    5'b11010    // saved register
`define READ_X27_S11    5'b11011    // saved register
`define READ_X28_T3     5'b11100    // temporary
`define READ_X29_T4     5'b11101    // temporary
`define READ_X30_T5     5'b11110    // temporary
`define READ_X31_T6     5'b11111    // temporary


// Opcode values (7-bit)
`define OPCODE_R        7'b0110011  // R-type
`define OPCODE_I        7'b0010011  // I-type (ALU with immediate)
`define OPCODE_LOAD     7'b0000011  // Load instructions
`define OPCODE_STORE    7'b0100011  // Store instructions
`define OPCODE_BRANCH   7'b1100011  // Branch instructions
`define OPCODE_JAL      7'b1101111  // Jump and link
`define OPCODE_JALR     7'b1100111  // Jump and link register
`define OPCODE_LUI      7'b0110111  // Load upper immediate
`define OPCODE_AUIPC    7'b0010111  // Add upper immediate to PC

// Immediate types
`define IMM_I           3'b000      // I-type immediate
`define IMM_S           3'b001      // S-type immediate
`define IMM_B           3'b010      // B-type immediate (branch)
`define IMM_U           3'b011      // U-type immediate
`define IMM_J           3'b100      // J-type immediate (jump)

// FUNCT3 values
`define FUNCT3_ADD      3'b000
`define FUNCT3_SUB      3'b000
`define FUNCT3_SLL      3'b001
`define FUNCT3_SLTU     3'b011
`define FUNCT3_XOR      3'b100
`define FUNCT3_SLT      3'b010
`define FUNCT3_OR       3'b110
`define FUNCT3_SRL      3'b101
`define FUNCT3_SRA      3'b101
`define FUNCT3_AND      3'b111

// FUNCT7 values
`define FUNCT7_ADD      7'b0000000
`define FUNCT7_SUB      7'b0100000
`define FUNCT7_SLL      7'b0000000
`define FUNCT7_SRL      7'b0000000
`define FUNCT7_SRA      7'b0100000

// Control signals
`define ALU_OP_ADD      3'b000
`define ALU_OP_SUB      3'b001
`define ALU_OP_LUI      3'b010
`define ALU_OP_SRL      3'b011
`define ALU_OP_SRA      3'b100
`define ALU_OP_AND      3'b101
`define ALU_OP_OR       3'b110
`define ALU_OP_XOR      3'b111

// CSR register addresses (12-bit)
`define CSR_MSTATUS    12'h300
`define CSR_MISA       12'h301
`define CSR_MIE        12'h304
`define CSR_MTVEC      12'h305
`define CSR_MEPC       12'h341
`define CSR_MCAUSE     12'h342
`define CSR_MTVAL      12'h343
`define CSR_MSCRATCH   12'h340

