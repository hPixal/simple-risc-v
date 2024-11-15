`timescale 1ns / 1ps
`include "../../risc-v-defines.v"

module alu_deco_tb;

    // Inputs
    reg op;
    reg f7;
    reg [2:0] f3;
    reg [1:0] aluOp;

    // Outputs
    wire [2:0] aluControl;

    // Instantiate the ALU Decoder module
    alu_deco uut (
        .op(op),
        .f7(f7),
        .f3(f3),
        .aluOp(aluOp),
        .aluControl(aluControl)
    );

    initial begin
        $dumpfile("alu_deco_tb.vcd");
        $dumpvars(0, alu_deco_tb);

        // Test case 1: Load/Store operation (aluOp = 2'b00), expected ALU_ADD
        aluOp = 2'b00; f3 = 3'b000; f7 = 0; op = 0;
        #10;
        $display("Test Case 1: aluOp=00, Expected=ALU_ADD, Got=%b", aluControl);

        // Test case 2: Branch BEQ operation (aluOp = 2'b01, f3 = 3'b000), expected ALU_BEQ
        aluOp = 2'b01; f3 = 3'b000;
        #10;
        $display("Test Case 2: aluOp=01, f3=000, Expected=ALU_BEQ, Got=%b", aluControl);

        // Test case 3: Branch BLT operation (aluOp = 2'b01, f3 = 3'b100), expected ALU_BLT
        f3 = 3'b100;
        #10;
        $display("Test Case 3: aluOp=01, f3=100, Expected=ALU_BLT, Got=%b", aluControl);

        // Test case 4: R-type ADD operation (aluOp = 2'b10, f3 = 3'b000, f7=0, op=0), expected ALU_ADD
        aluOp = 2'b10; f3 = 3'b000; f7 = 0; op = 0;
        #10;
        $display("Test Case 4: aluOp=10, f3=000, f7=0, op=0, Expected=ALU_ADD, Got=%b", aluControl);

        // Test case 5: R-type SUB operation (aluOp = 2'b10, f3 = 3'b000, f7=1, op=1), expected ALU_SUB
        f7 = 1; op = 1;
        #10;
        $display("Test Case 5: aluOp=10, f3=000, f7=1, op=1, Expected=ALU_SUB, Got=%b", aluControl);

        // Test case 6: R-type SLT operation (aluOp = 2'b10, f3 = 3'b010), expected ALU_SLT
        f3 = 3'b010; f7 = 0; op = 0;
        #10;
        $display("Test Case 6: aluOp=10, f3=010, Expected=ALU_SLT, Got=%b", aluControl);

        // Test case 7: R-type OR operation (aluOp = 2'b10, f3 = 3'b110), expected ALU_OR
        f3 = 3'b110;
        #10;
        $display("Test Case 7: aluOp=10, f3=110, Expected=ALU_OR, Got=%b", aluControl);

        // Test case 8: R-type AND operation (aluOp = 2'b10, f3 = 3'b111), expected ALU_AND
        f3 = 3'b111;
        #10;
        $display("Test Case 8: aluOp=10, f3=111, Expected=ALU_AND, Got=%b", aluControl);

        $finish;
    end

endmodule
