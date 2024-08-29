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
        // Initialize inputs
        clk = 0;
        rst = 0;
        en = 0;
        next_pc = 0;

        // Apply reset
        rst = 1;
        #10 rst = 0;

        // Test normal operation
        en = 1;
        next_pc = 32'h00000004;
        #10;

        next_pc = 32'h00000008;
        #10;

        next_pc = 32'h0000000C;
        #10;

        // Test stall (hold PC)
        en = 0;
        #10;

        // Test reset again
        rst = 1;
        #10 rst = 0;

        // Finish the simulation
        $finish;
    end

endmodule