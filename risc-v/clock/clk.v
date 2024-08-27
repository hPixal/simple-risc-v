module clk (
    output reg clk
);
    // Parameter to set the clock period
    parameter CLOCK_PERIOD = 10; // Clock period in time units

    initial begin
        clk = 0;
    end

    always begin
        # (CLOCK_PERIOD / 2) clk = ~clk; // Toggle the clock
    end

endmodule;