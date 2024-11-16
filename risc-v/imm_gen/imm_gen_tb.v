`timescale 1ns / 1ps
`include "../risc-v-defines.v"

module imm_gen_tb;

    // Inputs to the imm_gen module
    reg [31:0] instr;
    reg [2:0] imm_sel;
    
    // Output from the imm_gen module
    wire [31:0] imm_out;
    
    // Instantiate the imm_gen module
    imm_gen uut (
        .instr(instr),
        .imm_sel(imm_sel),
        .imm_out(imm_out)
    );
    
    // Test procedure
    initial begin
        $dumpfile("imm_gen_tb.vcd");
        $dumpvars(0, imm_gen_tb);

        // Initialize inputs
        instr = 32'b0;
        imm_sel = 3'b0;
        
        // Apply test cases for different imm_sel values
        
        // Test I-type immediate
        $display("Test I-type Immediate (IMM_I):");
        imm_sel = `IMM_I;
        instr = 32'hF0000000; // Test with an example instr (I-type)
        #10;
        $display("Instruction: %h, Immediate: %h", instr, imm_out);
        
        // Test S-type immediate
        $display("Test S-type Immediate (IMM_S):");
        imm_sel = `IMM_S;
        instr = 32'hFE000000; // Test with an example instr (S-type)
        #10;
        $display("Instruction: %h, Immediate: %h", instr, imm_out);
        
        // Test B-type immediate
        $display("Test B-type Immediate (IMM_B):");
        imm_sel = `IMM_B;
        instr = 32'hFF000000; // Test with an example instr (B-type)
        #10;
        $display("Instruction: %h, Immediate: %h", instr, imm_out);
        
        // Test U-type immediate
        $display("Test U-type Immediate (IMM_U):");
        imm_sel = `IMM_U;
        instr = 32'hFFFF0000; // Test with an example instr (U-type)
        #10;
        $display("Instruction: %h, Immediate: %h", instr, imm_out);
        
        // Test J-type immediate
        $display("Test J-type Immediate (IMM_J):");
        imm_sel = `IMM_J;
        instr = 32'hFFFFFFF0; // Test with an example instr (J-type)
        #10;
        $display("Instruction: %h, Immediate: %h", instr, imm_out);
        
        // End simulation
        $finish;
    end

endmodule
