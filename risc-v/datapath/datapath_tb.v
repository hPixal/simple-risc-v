module datapath_tb;

    // Inputs
    reg clk;
    reg rst;

    // Outputs
    wire [31:0] pc_out;

    // Instantiate the datapath
    datapath uut (
        .clk(clk),
        .rst(rst),
        .pc_out(pc_out)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end

    // Test procedure
    initial begin
        $dumpfile("datapath_tb.vcd");
        $dumpvars(0, datapath_tb);

        // Initialize reset
        rst = 1;
        #20;
        rst = 0;

        // Test sequence
        // 1. Load a program into instruction memory (manually, since imem is simplified).
        // 2. Validate instruction fetch, decoding, ALU operation, memory access, etc.
        //    This example assumes a hardcoded instruction sequence for simplicity.

        // Wait for a few clock cycles
        #120;

        // Add additional assertions and checks as necessary
        // (e.g., observe outputs, debug intermediate values, etc.)

        // Finish simulation
        $finish;
    end

    // Observe PC
    initial begin
        $monitor("Time: %0d | PC: %0h", $time, pc_out);
    end

endmodule
