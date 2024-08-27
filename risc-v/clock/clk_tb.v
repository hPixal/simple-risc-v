module clk_tb;
    // Signal to hold the clock output from the clock generator
    wire clk;

    // Instantiate the clock generator
    clk #(
        .CLOCK_PERIOD(10)  // Set the clock period to 10 time units
    ) uut (
        .clk(clk)
    );

    // Simulation control
    initial begin
        $dumpfile("clk_tb.vcd");
        $dumpvars(0, clk_tb);
        // Run the simulation for 100 time units
        #90;
        // Stop the simulation
        $finish;
    end

    // Monitor the clock signal to observe its behavior
    initial begin
        $monitor("Time = %0t : clk = %b", $time, clk);
    end
endmodule
