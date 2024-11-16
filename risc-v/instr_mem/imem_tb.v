`timescale 1ns/1ps
`include "../risc-v-defines.v"


module imem_tb;

    reg [31:0] addr;             // Address input
    wire [31:0] instruction;     // Output instruction

    // Instantiate the IMEM module
    imem uut (
        .addr(addr),
        .instruction(instruction)
    );

    parameter CLK_PERIOD = 10;

    initial begin
        $dumpfile("imem_tb.vcd");
        $dumpvars(0, imem_tb);

        $display("Starting IMEM test...");

        // Test predefined ROM values
        addr = 32'h00000000; #CLK_PERIOD;
        $display("Addr: %h, Instruction: %h (Expected: 40000593)", addr, instruction);

        addr = 32'h00000004; #CLK_PERIOD;
        $display("Addr: %h, Instruction: %h (Expected: 40058593)", addr, instruction);

        addr = 32'h00000008; #CLK_PERIOD;
        $display("Addr: %h, Instruction: %h (Expected: 0145a803)", addr, instruction);

        addr = 32'h0000000C; #CLK_PERIOD;
        $display("Addr: %h, Instruction: %h (Expected: fe080ee3)", addr, instruction);

        addr = 32'h00000010; #CLK_PERIOD;
        $display("Addr: %h, Instruction: %h (Expected: 0005a603)", addr, instruction);

        addr = 32'h00000014; #CLK_PERIOD;
        $display("Addr: %h, Instruction: %h (Expected: 0045a683)", addr, instruction);

        addr = 32'h000000B4; #CLK_PERIOD;
        $display("Addr: %h, Instruction: %h (Expected: 407b8bb3)", addr, instruction);

        addr = 32'h000000C4; #CLK_PERIOD;
        $display("Addr: %h, Instruction: %h (Expected: f45ff0ef)", addr, instruction);

        // Access uninitialized ROM address
        addr = 32'h000000C8; #CLK_PERIOD;
        $display("Addr: %h, Instruction: %h (Expected: 00000000)", addr, instruction);

        $display("IMEM test completed.");
        $finish;
    end

endmodule
