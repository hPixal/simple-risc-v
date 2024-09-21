`timescale 1ns/1ps
// `include "imm_gen.v" // Adjust the path if needed

module imm_gen_tb;

    // Inputs
    reg clk;
    reg rst;
    reg [31:0] inst;

    // Outputs
    wire [31:0] imm;

    // Instantiate the Unit Under Test (UUT)
    imm_gen uut (
        .clk(clk),
        .rst(rst),
        .inst(inst),
        .imm(imm)
    );

    // Clock generation
    always begin
        #5 clk = ~clk; // Toggle every 5 time units
    end

    // Test cases
    initial begin
        $dumpfile("imm_gen_tb.vcd");
        $dumpvars(0, imm_gen_tb);
        // Initialize Inputs
        clk = 0;
        rst = 1;
        inst = 32'b0;

        // Apply reset
        #10 rst = 0;

        // Test I-Type instruction
        // Separated binary 0000 0000 0001 0000 0000 0000 0010 0011 OPCODE: 0010011 I_TYPE
        inst = 32'b00000000000100000000000000100011; // Example ADDI instruction
        #10;
        $display("I-Type Imm: %h (Expected: %h)", imm, 32'h00000001);

        // Test S-Type instruction
        // Separated binary 0000 0000 0000 0000 0000 0000 0010 0011 OPCODE: 0100011 S_TYPE
        inst = 32'b00000000000100000001000001000011; // Example SW instruction
        #10;
        $display("S-Type Imm: %h (Expected: %h)", imm, 32'h00000100);

        // Test B-Type instruction
        // Separated binary 0000 0000 0000 0000 0000 0000 1100 0011 OPCODE: 1100011 B_TYPE
        inst = 32'b00000000001000000010000001100011; // Example BEQ instruction
        #10;
        $display("B-Type Imm: %h (Expected: %h)", imm, 32'h00000800);

        // Test U-Type instruction
        inst = 32'b00000000000100000000000001101111; // Example LUI instruction
        #10;
        $display("U-Type Imm: %h (Expected: %h)", imm, 32'h00000100);

        // Test J-Type instruction
        inst = 32'b00000000000000010000000000001111; // Example JAL instruction
        #10;
        $display("J-Type Imm: %h (Expected: %h)", imm, 32'h00000010);

        // Test reset functionality
        rst = 1;
        #10;
        rst = 0;
        inst = 32'b00000000000000000000000000000000; // Reset to default instruction
        #10;
        $display("Reset Imm: %h (Expected: %h)", imm, 32'h00000000);

        // Finish simulation
        $finish;
    end
endmodule
