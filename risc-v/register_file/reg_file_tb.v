`timescale 1ns/1ps
`include "../risc-v-defines.v"

module reg_file_tb;

    // Inputs
    reg clk;
    reg we;
    reg rst;
    reg [4:0] ra1;
    reg [4:0] ra2;
    reg [4:0] wa;
    reg [31:0] wd;

    // Outputs
    wire [31:0] rd1;
    wire [31:0] rd2;

    // Instantiate the reg_file module
    reg_file reg_file_uut (
        .clk(clk),
        .we(we),
        .rst(rst),
        .ra1(ra1),
        .ra2(ra2),
        .wa(wa),
        .wd(wd),
        .rd1(rd1),
        .rd2(rd2)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Toggle clock every 5 time units (10 units period)
    end

    initial begin
        $dumpfile("reg_file_tb.vcd");
        $dumpvars(0, reg_file_tb);

        // Initialize Inputs
        we = 0;
        rst = 1;
        ra1 = 0;
        ra2 = 0;
        wa = 0;
        wd = 0;

        // Apply reset
        #10 rst = 0;

        // Write to register x1 (ra)
        we = 1;
        wa = `READ_X1_RA;
        wd = 32'h12345678;
        #10;

        // Write to register x2 (sp)
        wa = `READ_X2_SP;
        wd = 32'h87654321;
        #10;

        // Disable write enable
        we = 0;

        // Read from registers x1 and x2
        ra1 = `READ_X1_RA;
        ra2 = `READ_X2_SP;
        #10;

        // Display read data
        $display("rd1 = %h, expected = %h", rd1, 32'h12345678);
        $display("rd2 = %h, expected = %h", rd2, 32'h87654321);

        // Test reset functionality
        rst = 1;
        #10;
        rst = 0;
        ra1 = `READ_X1_RA;
        ra2 = `READ_X2_SP;
        #10;

        // Display read data after reset
        $display("rd1 after reset = %h, expected = %h", rd1, 32'h00000000);
        $display("rd2 after reset = %h, expected = %h", rd2, 32'h00000000);

        // Finish simulation
        $finish;
    end
endmodule
