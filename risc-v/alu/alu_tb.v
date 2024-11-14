`timescale 1ns / 1ps
`include "../risc-v-defines.v"

module alu_tb;

    // Inputs
    reg clk;
    reg rst;
    reg [3:0] op;
    reg [31:0] in_a;
    reg [31:0] in_b;

    // Output
    wire [31:0] out_s;

    // Instantiate the ALU
    alu uut (
        .clk(clk),
        .rst(rst),
        .op(op),
        .in_a(in_a),
        .in_b(in_b),
        .out_s(out_s)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns period clock
    end

    // Test sequence
    initial begin
        $dumpfile("alu_tb.vcd");
        $dumpvars(0, alu_tb);

        // Initialize inputs
        rst = 0;
        op = 4'b0000;
        in_a = 32'h5;
        in_b = 32'h5;

        // Apply reset
        #10 rst = 0;

        // Test ALU_ADD
        op = `ALU_ADD;
        in_a = 32'h00000010;
        in_b = 32'h00000020;
        #10;
        $display("ALU_ADD: %h + %h = %h", in_a, in_b, out_s);

        // Test ALU_SUB
        op = `ALU_SUB;
        in_a = 32'h00000030;
        in_b = 32'h00000010;
        #10;
        $display("ALU_SUB: %h - %h = %h", in_a, in_b, out_s);

        // Additional tests for other operations...
        // Test ALU_SLL, ALU_SRL, ALU_SRA, ALU_XOR, etc.

        // Complete the simulation
        $finish;
    end
endmodule
