module csr (
    input wire clk,                // Clock signal
    input wire rst,                // Reset signal (active high)
    input wire csr_write,          // Write enable signal
    input wire csr_read,           // Read enable signal
    input wire [11:0] csr_addr,    // CSR address (12-bit)
    input wire [31:0] csr_write_data, // Data to write to the CSR
    output reg [31:0] csr_read_data   // Data read from the CSR
);

    // Define CSR addresses
    localparam MSTATUS   = 12'h300;  // Machine Status Register
    localparam MTVEC     = 12'h305;  // Machine Trap-Vector Base Address
    localparam MEPC      = 12'h341;  // Machine Exception Program Counter
    localparam MCAUSE    = 12'h342;  // Machine Cause Register

    // CSR register file
    reg [31:0] csr_file [0:4095]; // 4096 CSRs (12-bit address space)

    // Reset initialization
    integer i;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for (i = 0; i < 4096; i = i + 1) begin
                csr_file[i] <= 32'h0; // Clear all CSRs
            end
            // Initialize specific CSRs
            csr_file[MSTATUS] <= 32'h0;
            csr_file[MTVEC]   <= 32'h0;
            csr_file[MEPC]    <= 32'h0;
            csr_file[MCAUSE]  <= 32'h0;
        end else if (csr_write) begin
            csr_file[csr_addr] <= csr_write_data; // Write to CSR
        end
    end

    // CSR read operation
    always @(*) begin
        if (csr_read) begin
            csr_read_data = csr_file[csr_addr];
        end else begin
            csr_read_data = 32'h0;
        end
    end

endmodule
