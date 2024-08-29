`include "../risc-v-defines.v"

module pc (
    input wire clk,        // Clock input
    input wire rst,        // Reset input (active high)
    input wire en,         // Enable signal (if not enabled, PC holds its value)
    input wire [31:0] next_pc, // Next PC value to be loaded into the PC
    output reg [31:0] pc_out  // Current PC value
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset the PC to 0 on reset
            pc_out <= 32'h00000000;
        end else if (en) begin
            // Update the PC if enabled
            pc_out <= next_pc;
        end
    end

endmodule