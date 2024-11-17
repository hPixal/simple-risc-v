module dmem (
    input wire clk,                  // Clock signal
    input wire mem_write,            // Memory write enable
    input wire mem_read,             // Memory read enable
    input wire [31:0] address,       // Memory address
    input wire [31:0] write_data,    // Data to write into memory
    output reg [31:0] read_data      // Data read from memory
);

    parameter MEM_SIZE = 256;        // Memory size in words (adjust as needed)

    // Memory declaration: Array of 32-bit registers
    reg [31:0] memory [0:MEM_SIZE-1];

    // Memory Write
    always @(posedge clk) begin
        if (mem_write) begin
            memory[address[7:2]] <= write_data; // Write data to memory
        end
    end

    // Memory Read
    always @(*) begin
        if (mem_read) begin
            read_data = memory[address[7:2]]; // Read data from memory
        end else begin
            read_data = 32'b0; // Default to zero when not reading
        end
    end

endmodule
