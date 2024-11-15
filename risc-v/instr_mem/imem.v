`timescale 1ns / 1ps

module imem(
    input wire clk,            // Clock input (positive edge triggered)
    input wire [31:0] addr,    // Address input (from the program counter)
    output reg [31:0] instr    // Instruction output
);

    // Instruction memory (ROM) initialized with instructions
    reg [31:0] memory [0:255];  // 256 words of 32-bit instruction memory

    always @(posedge clk) begin
        // Fetch the instruction at the given address
        instr <= memory[addr[9:2]];  // Addr is word-aligned, so we use addr[9:2]
    end
endmodule