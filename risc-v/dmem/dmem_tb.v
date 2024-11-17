`timescale 1ns / 1ps

module dmem_tb;

    // Inputs
    reg clk;
    reg mem_write;
    reg mem_read;
    reg [31:0] address;
    reg [31:0] write_data;

    // Output
    wire [31:0] read_data;

    // Instantiate the DMEM module
    dmem uut (
        .clk(clk),
        .mem_write(mem_write),
        .mem_read(mem_read),
        .address(address),
        .write_data(write_data),
        .read_data(read_data)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10 ns clock period
    end

    // Test sequence
    initial begin
        $dumpfile("dmem_tb.vcd");
        $dumpvars(0, dmem_tb);
        // Initialize inputs
        mem_write = 0;
        mem_read = 0;
        address = 0;
        write_data = 0;

        // Wait for global reset
        #10;

        // Test 1: Write to address 0x04
        address = 32'h04;
        write_data = 32'hDEADBEEF;
        mem_write = 1;
        #10;
        mem_write = 0; // Disable write

        // Test 2: Write to address 0x08
        address = 32'h08;
        write_data = 32'hCAFEBABE;
        mem_write = 1;
        #10;
        mem_write = 0; // Disable write

        // Test 3: Read from address 0x04
        address = 32'h04;
        mem_read = 1;
        #10;
        mem_read = 0; // Disable read

        // Test 4: Read from address 0x08
        address = 32'h08;
        mem_read = 1;
        #10;
        mem_read = 0; // Disable read

        // Test 5: Read from uninitialized address 0x0C
        address = 32'h0C;
        mem_read = 1;
        #10;
        mem_read = 0; // Disable read

        // Test 6: Attempt to write when mem_write is disabled
        address = 32'h0C;
        write_data = 32'h12345678;
        #10;

        // End simulation
        $finish;
    end

endmodule
