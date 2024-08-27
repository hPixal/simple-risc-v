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