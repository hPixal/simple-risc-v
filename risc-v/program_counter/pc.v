`include "../risc-v-defines.v"

module pc (
    input wire clk,             // Clock input
    input wire rst,             // Reset input (active high)
    input wire en,              // Enable signal (if not enabled, PC holds its value)
    input wire [31:0] next_pc,  // Next PC value to be loaded into the PC
    output reg [31:0] pc_out    // Current PC value
);

    parameter RESET_PC_VALUE = 32'h00000000;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset the PC to 0 on reset
            pc_out <= RESET_PC_VALUE;
        end else if (en) begin
            // Update the PC if enabled
            pc_out <= next_pc;
        end else begin
            // Default behavior: increment PC by 4 for the next instruction
            pc_out <= pc_out + 4;
        end
    end

endmodule
