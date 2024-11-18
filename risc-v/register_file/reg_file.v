`include "../risc-v-defines.v"

module reg_file #(parameter wth = 32) (
    input wire clk,       // Clock
    input wire we,        // Write enable
    input wire rst,       // Reset
    input wire [4:0] ra1, // Read address 1
    input wire [4:0] ra2, // Read address 2
    input wire [4:0] wa,  // Write address
    input wire [31:0] wd, // Write data
    output reg [31:0] rd1,// Read data 1
    output reg [31:0] rd2 // Read data 2
);

reg  [31:0] rg_x1_ra;      // return address
reg  [31:0] rg_x2_sp;      // stack pointer 
reg  [31:0] rg_x3_gp;      // global pointer
reg  [31:0] rg_x4_tp;      // thread pointer
reg  [31:0] rg_x5_t0;      // temporary/alternate link register
reg  [31:0] rg_x6_t1;      // temporary
reg  [31:0] rg_x7_t2;      // temporary
reg  [31:0] rg_x8_s0;      // saved register/frame pointer
reg  [31:0] rg_x9_s1;      // saved register
reg  [31:0] rg_x10_a0;     // function argument/return value
reg  [31:0] rg_x11_a1;     // function argument/return value
reg  [31:0] rg_x12_a2;     // function argument
reg  [31:0] rg_x13_a3;     // function argument
reg  [31:0] rg_x14_a4;     // function argument
reg  [31:0] rg_x15_a5;     // function argument
reg  [31:0] rg_x16_a6;     // function argument
reg  [31:0] rg_x17_a7;     // function argument
reg  [31:0] rg_x18_s2;     // saved register
reg  [31:0] rg_x19_s3;     // saved register
reg  [31:0] rg_x20_s4;     // saved register
reg  [31:0] rg_x21_s5;     // saved register
reg  [31:0] rg_x22_s6;     // saved register
reg  [31:0] rg_x23_s7;     // saved register
reg  [31:0] rg_x24_s8;     // saved register
reg  [31:0] rg_x25_s9;     // saved register
reg  [31:0] rg_x26_s10;    // saved register
reg  [31:0] rg_x27_s11;    // saved register
reg  [31:0] rg_x28_t3;     // temporary
reg  [31:0] rg_x29_t4;     // temporary
reg  [31:0] rg_x30_t5;     // temporary
reg  [31:0] rg_x31_t6;     // temporary
    
always @ (posedge clk) begin
    if (rst == 1'b1) begin // If reset enabled, reset all registers
        rg_x1_ra    =  32'h00000000;
        rg_x2_sp    =  32'h00000000;  
        rg_x3_gp    =  32'h00000000;  
        rg_x4_tp    =  32'h00000000;  
        rg_x5_t0    =  32'h00000000;  
        rg_x6_t1    =  32'h00000000;  
        rg_x7_t2    =  32'h00000000;  
        rg_x8_s0    =  32'h00000000;  
        rg_x9_s1    =  32'h00000000;  
        rg_x10_a0   =  32'h00000000;
        rg_x11_a1   =  32'h00000000;
        rg_x12_a2   =  32'h00000000;
        rg_x13_a3   =  32'h00000000;
        rg_x14_a4   =  32'h00000000;
        rg_x15_a5   =  32'h00000000;
        rg_x16_a6   =  32'h00000000;
        rg_x17_a7   =  32'h00000000;
        rg_x18_s2   =  32'h00000000;
        rg_x19_s3   =  32'h00000000;
        rg_x20_s4   =  32'h00000000;
        rg_x21_s5   =  32'h00000000;
        rg_x22_s6   =  32'h00000000;
        rg_x23_s7   =  32'h00000000;
        rg_x24_s8   =  32'h00000000;
        rg_x25_s9   =  32'h00000000;
        rg_x26_s10  =  32'h00000000;
        rg_x27_s11  =  32'h00000000;
        rg_x28_t3   =  32'h00000000;
        rg_x29_t4   =  32'h00000000;
        rg_x30_t5   =  32'h00000000;
        rg_x31_t6   =  32'h00000000;
    end
    else if (we == 1'b1) begin
        case (wa)
            `READ_X1_RA  : rg_x1_ra     <= wd;
            `READ_X2_SP  : rg_x2_sp     <= wd;
            `READ_X3_GP  : rg_x3_gp     <= wd;
            `READ_X4_TP  : rg_x4_tp     <= wd;
            `READ_X5_T0  : rg_x5_t0     <= wd;
            `READ_X6_T1  : rg_x6_t1     <= wd;
            `READ_X7_T2  : rg_x7_t2     <= wd;
            `READ_X8_S0  : rg_x8_s0     <= wd;
            `READ_X9_S1  : rg_x9_s1     <= wd;
            `READ_X10_A0 : rg_x10_a0    <= wd;
            `READ_X11_A1 : rg_x11_a1    <= wd;
            `READ_X12_A2 : rg_x12_a2    <= wd;
            `READ_X13_A3 : rg_x13_a3    <= wd;
            `READ_X14_A4 : rg_x14_a4    <= wd;
            `READ_X15_A5 : rg_x15_a5    <= wd;
            `READ_X16_A6 : rg_x16_a6    <= wd;
            `READ_X17_A7 : rg_x17_a7    <= wd;
            `READ_X18_S2 : rg_x18_s2    <= wd;
            `READ_X19_S3 : rg_x19_s3    <= wd;
            `READ_X20_S4 : rg_x20_s4    <= wd;
            `READ_X21_S5 : rg_x21_s5    <= wd;
            `READ_X22_S6 : rg_x22_s6    <= wd;
            `READ_X23_S7 : rg_x23_s7    <= wd;
            `READ_X24_S8 : rg_x24_s8    <= wd;
            `READ_X25_S9 : rg_x25_s9    <= wd;
            `READ_X26_S10: rg_x26_s10   <= wd;
            `READ_X27_S11: rg_x27_s11   <= wd;
            `READ_X28_T3 : rg_x28_t3    <= wd;
            `READ_X29_T4 : rg_x29_t4    <= wd;
            `READ_X30_T5 : rg_x30_t5    <= wd;
            `READ_X31_T6 : rg_x31_t6    <= wd;
        endcase
    end
end

always @ (*) begin
    case (ra1)
        `READ_X0_ZERO: rd1 <= 32'b0;
        `READ_X1_RA  : rd1 <= rg_x1_ra  ;  
        `READ_X2_SP  : rd1 <= rg_x2_sp  ;  
        `READ_X3_GP  : rd1 <= rg_x3_gp  ;  
        `READ_X4_TP  : rd1 <= rg_x4_tp  ;  
        `READ_X5_T0  : rd1 <= rg_x5_t0  ;  
        `READ_X6_T1  : rd1 <= rg_x6_t1  ;  
        `READ_X7_T2  : rd1 <= rg_x7_t2  ;  
        `READ_X8_S0  : rd1 <= rg_x8_s0  ;  
        `READ_X9_S1  : rd1 <= rg_x9_s1  ;  
        `READ_X10_A0 : rd1 <= rg_x10_a0 ;  
        `READ_X11_A1 : rd1 <= rg_x11_a1 ;  
        `READ_X12_A2 : rd1 <= rg_x12_a2 ;  
        `READ_X13_A3 : rd1 <= rg_x13_a3 ;  
        `READ_X14_A4 : rd1 <= rg_x14_a4 ;  
        `READ_X15_A5 : rd1 <= rg_x15_a5 ;  
        `READ_X16_A6 : rd1 <= rg_x16_a6 ;  
        `READ_X17_A7 : rd1 <= rg_x17_a7 ;  
        `READ_X18_S2 : rd1 <= rg_x18_s2 ;  
        `READ_X19_S3 : rd1 <= rg_x19_s3 ;  
        `READ_X20_S4 : rd1 <= rg_x20_s4 ;  
        `READ_X21_S5 : rd1 <= rg_x21_s5 ;  
        `READ_X22_S6 : rd1 <= rg_x22_s6 ;  
        `READ_X23_S7 : rd1 <= rg_x23_s7 ;  
        `READ_X24_S8 : rd1 <= rg_x24_s8 ;  
        `READ_X25_S9 : rd1 <= rg_x25_s9 ;  
        `READ_X26_S10: rd1 <= rg_x26_s10;  
        `READ_X27_S11: rd1 <= rg_x27_s11;  
        `READ_X28_T3 : rd1 <= rg_x28_t3 ;  
        `READ_X29_T4 : rd1 <= rg_x29_t4 ;  
        `READ_X31_T6 : rd1 <= rg_x30_t5 ;  
        `READ_X30_T5 : rd1 <= rg_x31_t6 ;
        default:
            rd1 <= 32'b0;
    endcase
    case (ra2)
        `READ_X0_ZERO: rd2 <= 32'b0;
        `READ_X1_RA  : rd2 <= rg_x1_ra  ;  
        `READ_X2_SP  : rd2 <= rg_x2_sp  ;  
        `READ_X3_GP  : rd2 <= rg_x3_gp  ;  
        `READ_X4_TP  : rd2 <= rg_x4_tp  ;  
        `READ_X5_T0  : rd2 <= rg_x5_t0  ;  
        `READ_X6_T1  : rd2 <= rg_x6_t1  ;  
        `READ_X7_T2  : rd2 <= rg_x7_t2  ;  
        `READ_X8_S0  : rd2 <= rg_x8_s0  ;  
        `READ_X9_S1  : rd2 <= rg_x9_s1  ;  
        `READ_X10_A0 : rd2 <= rg_x10_a0 ;  
        `READ_X11_A1 : rd2 <= rg_x11_a1 ;  
        `READ_X12_A2 : rd2 <= rg_x12_a2 ;  
        `READ_X13_A3 : rd2 <= rg_x13_a3 ;  
        `READ_X14_A4 : rd2 <= rg_x14_a4 ;  
        `READ_X15_A5 : rd2 <= rg_x15_a5 ;  
        `READ_X16_A6 : rd2 <= rg_x16_a6 ;  
        `READ_X17_A7 : rd2 <= rg_x17_a7 ;  
        `READ_X18_S2 : rd2 <= rg_x18_s2 ;  
        `READ_X19_S3 : rd2 <= rg_x19_s3 ;  
        `READ_X20_S4 : rd2 <= rg_x20_s4 ;  
        `READ_X21_S5 : rd2 <= rg_x21_s5 ;  
        `READ_X22_S6 : rd2 <= rg_x22_s6 ;  
        `READ_X23_S7 : rd2 <= rg_x23_s7 ;  
        `READ_X24_S8 : rd2 <= rg_x24_s8 ;  
        `READ_X25_S9 : rd2 <= rg_x25_s9 ;  
        `READ_X26_S10: rd2 <= rg_x26_s10;  
        `READ_X27_S11: rd2 <= rg_x27_s11;  
        `READ_X28_T3 : rd2 <= rg_x28_t3 ;  
        `READ_X29_T4 : rd2 <= rg_x29_t4 ;  
        `READ_X31_T6 : rd2 <= rg_x30_t5 ;  
        `READ_X30_T5 : rd2 <= rg_x31_t6 ;
        default:
            rd2 <= 32'b0;
    endcase
end

endmodule