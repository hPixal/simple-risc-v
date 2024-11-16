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
`define READ_X30_T5 5'b11110    // temporary
`define READ_X31_T6 5'b11111    // temporary

// ALU operation codes
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

// Opcode values (7-bit)
`define OPCODE_R    7'b0110011  // R-type instructions (e.g., add, sub)
`define OPCODE_I    7'b0010011  // I-type instructions (e.g., addi, ori)
`define OPCODE_LOAD 7'b0000011  // Load instructions
`define OPCODE_STORE 7'b0100011 // Store instructions
`define OPCODE_BRANCH 7'b1100011 // Branch instructions
`define OPCODE_JAL  7'b1101111  // JAL (jump and link)
`define OPCODE_JALR 7'b1100111  // JALR (jump and link register)
`define OPCODE_LUI  7'b0110111  // Load Upper Immediate
`define OPCODE_AUIPC 7'b0010111 // Add Upper Immediate to PC

// Immediate types
`define IMM_I       3'b000      // I-type immediate
`define IMM_S       3'b001      // S-type immediate
`define IMM_B       3'b010      // B-type immediate (branch)
`define IMM_U       3'b011      // U-type immediate
`define IMM_J       3'b100      // J-type immediate (jump)

// Control signals
`define ALU_OP_ADD  3'b000
`define ALU_OP_SUB  3'b001
`define ALU_OP_LUI  3'b010
`define ALU_OP_SRL  3'b011
`define ALU_OP_SRA  3'b100
`define ALU_OP_AND  3'b101
`define ALU_OP_OR   3'b110
`define ALU_OP_XOR  3'b111

// CSR register addresses (12-bit)
`define CSR_MSTATUS   12'h300   // Machine status register
`define CSR_MISA      12'h301   // ISA and extensions
`define CSR_MEPC      12'h341   // Machine exception program counter
`define CSR_MCAUSE    12'h342   // Machine cause register
`define CSR_MTVAL     12'h343   // Machine trap value
`define CSR_MTVEC     12'h305   // Machine trap-vector base address
`define CSR_MSCRATCH  12'h340   // Machine scratch register
