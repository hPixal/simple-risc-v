module reduced_datapath_tb;

    // Inputs
    reg [6:0] op;
    reg [1:0] aluOp;
    reg [2:0] f3;
    reg f7;
    reg [31:0] srcA, srcB;

    // Outputs
    wire branch, jump, memWrite, aluSrc, regWrite, zero;
    wire [1:0] resSrc, immSrc, aluOpOut;
    wire [2:0] aluControl;
    wire [31:0] aluResult;

    // Instantiate the components
    mainDeco main_deco (
        .op(op),
        .branch(branch),
        .jump(jump),
        .resSrc(resSrc),
        .memWrite(memWrite),
        .aluSrc(aluSrc),
        .immSrc(immSrc),
        .regWrite(regWrite),
        .aluOp(aluOpOut)
    );

    aluDeco alu_deco (
        .op(f7),
        .f7(f7),
        .f3(f3),
        .aluOp(aluOpOut),
        .aluControl(aluControl)
    );

    ALU alu (
        .srcA(srcA),
        .srcB(srcB),
        .ALUControl(aluControl),
        .zero(zero),
        .res(aluResult)
    );

    // Testbench logic
    initial begin
        // Dump waveform for debugging
        $dumpfile("reduced_datapath_tb.vcd");
        $dumpvars(0, reduced_datapath_tb);

        // Test case 1: R-Type instruction (ADD)
        op = 7'b0110011; // R-Type opcode
        aluOp = 2'b10;
        f3 = 3'b000;  // ADD
        f7 = 1'b0;    // Not SUB
        srcA = 32'h00000010;
        srcB = 32'h00000020;

        #10; // Wait for signals to propagate
        $display("Test 1 - R-Type, op: %b, aluOp: %b, f3: %b, f7: %b ADD:", op, aluOp, f3, f7);
        $display("ALU Result: %h, Zero: %b", aluResult, zero);

        // Test case 2: R-Type instruction (SUB)
        f7 = 1'b1; // SUB
        #10;
        $display("Test 2 - R-Type SUB:");
        $display("ALU Result: %h, Zero: %b", aluResult, zero);

        // Test case 3: Branch (BEQ)
        op = 7'b1100011; // Branch opcode
        f3 = 3'b000;     // BEQ
        srcA = 32'h00000030;
        srcB = 32'h00000030;
        #10;
        $display("Test 3 - Branch BEQ:");
        $display("ALU Result: %h, Zero: %b", aluResult, zero);

        // End simulation
        $finish;
    end

endmodule
