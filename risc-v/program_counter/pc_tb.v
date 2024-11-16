module pc_tb;
    reg clk;
    reg rst;
    reg en;
    reg [31:0] next_pc;
    wire [31:0] pc_out;

    // Instantiate the Program Counter
    pc pc_uut (
        .clk(clk),
        .rst(rst),
        .en(en),
        .next_pc(next_pc),
        .pc_out(pc_out)
    );

    // Clock generation
    always #5 clk = ~clk; // Clock period of 10 units

    initial begin
        $dumpfile("pc_tb.vcd");
        $dumpvars(0, pc_tb);
        // Initialize signals
        clk = 0;
        rst = 0;
        en = 0;
        next_pc = 0;

        // Test 1: Apply reset
        $display("Test 1: Applying reset");
        rst = 1;
        #10;
        rst = 0;
        $display("PC after reset: %h (expected: 0)", pc_out);
        #10;

        // Test 2: Increment PC when en is low
        $display("Test 2: Increment PC by 4 when en is low");
        en = 0;
        #10;
        $display("PC value: %h (expected: 4)", pc_out);
        #10;
        $display("PC value: %h (expected: 8)", pc_out);
        #10;

        // Test 3: Load specific next_pc value when en is high
        $display("Test 3: Loading a specific next_pc value");
        en = 1;
        next_pc = 32'h00000020;
        #10;
        $display("PC value after loading next_pc: %h (expected: 20)", pc_out);
        en = 0;  // Disable PC update
        #10;
        $display("PC value: %h (expected: 24)", pc_out);

        // Test 4: Increment again after loading
        #10;
        $display("PC value: %h (expected: 28)", pc_out);

        // Finish simulation
        $finish;
    end

endmodule