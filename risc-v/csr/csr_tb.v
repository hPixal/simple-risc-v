`timescale 1ns / 1ps

module csr_tb;

    // Testbench signals
    reg clk;                     // Clock signal
    reg rst;                     // Reset signal
    reg csr_write;               // Write enable
    reg csr_read;                // Read enable
    reg [11:0] csr_addr;         // CSR address
    reg [31:0] csr_write_data;   // Data to write
    wire [31:0] csr_read_data;   // Data read from CSR

    // DUT instantiation
    csr uut (
        .clk(clk),
        .rst(rst),
        .csr_write(csr_write),
        .csr_read(csr_read),
        .csr_addr(csr_addr),
        .csr_write_data(csr_write_data),
        .csr_read_data(csr_read_data)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end

    // Test procedure
    initial begin
        $dumpfile("csr_tb.vcd");
        $dumpvars(0, csr_tb);

        // Initialize inputs
        rst = 0;
        csr_write = 0;
        csr_read = 0;
        csr_addr = 12'h000;
        csr_write_data = 32'h00000000;

        // Apply reset
        $display("Applying reset...");
        rst = 1;
        #10;
        rst = 0;
        #10;

        // Verify reset state
        csr_read = 1;
        csr_addr = 12'h300; // MSTATUS
        #10;
        $display("Read MSTATUS after reset: 0x%h", csr_read_data);

        // Write to MSTATUS
        $display("Writing to MSTATUS...");
        csr_read = 0;
        csr_write = 1;
        csr_addr = 12'h300; // MSTATUS
        csr_write_data = 32'hdeadbeef;
        #10;
        csr_write = 0;

        // Read back MSTATUS
        csr_read = 1;
        #10;
        $display("Read MSTATUS after write: 0x%h", csr_read_data);

        // Write to another CSR (MEPC)
        $display("Writing to MEPC...");
        csr_read = 0;
        csr_write = 1;
        csr_addr = 12'h341; // MEPC
        csr_write_data = 32'h12345678;
        #10;
        csr_write = 0;

        // Read back MEPC
        csr_read = 1;
        csr_addr = 12'h341; // MEPC
        #10;
        $display("Read MEPC after write: 0x%h", csr_read_data);

        // Invalid address read
        $display("Reading from an invalid address...");
        csr_read = 1;
        csr_addr = 12'hFFF; // Invalid address
        #10;
        $display("Read invalid CSR: 0x%h", csr_read_data);

        $finish;
    end

endmodule
