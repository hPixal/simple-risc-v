`include "../risc-v-defines.v"

module imem (
    input wire [31:0] addr,       // Address input (usually the PC value)
    output reg [31:0] instruction // Output instruction at the given address
);

    parameter ROM_WIDTH = 32;
    parameter ROM_ADDR_BITS = 8;
    (* ROM_STYLE="{AUTO |DISTRIBUTED |BLOCK}" *)
    reg [ROM_WIDTH-1:0] ROM [(2**ROM_ADDR_BITS)-1:0];

    initial begin
        ROM[0] = 32'h40000593;
        ROM[1] = 32'h40058593;
        ROM[2] = 32'h0145a803;
        ROM[3] = 32'hfe080ee3;
        ROM[4] = 32'h0005a603;
        ROM[5] = 32'h0045a683;
        ROM[6] = 32'h00c5a703;
        ROM[7] = 32'h0105a783;
        ROM[8] = 32'hfd060613;
        ROM[9] = 32'hfd068693;
        ROM[10] = 32'hfd070713;
        ROM[11] = 32'hfd078793;
        ROM[12] = 32'h00060293;
        ROM[13] = 32'h00070313;
        ROM[14] = 32'h00900393;
        ROM[15] = 32'h00038a63;
        ROM[16] = 32'h00560633;
        ROM[17] = 32'h00670733;
        ROM[18] = 32'hfff38393;
        ROM[19] = 32'hff1ff0ef;
        ROM[20] = 32'h00d60633;
        ROM[21] = 32'h00f70733;
        ROM[22] = 32'h00c002b3;
        ROM[23] = 32'hfff70713;
        ROM[24] = 32'h00070863;
        ROM[25] = 32'h00560633;
        ROM[26] = 32'hfff70713;
        ROM[27] = 32'hff5ff0ef;
        ROM[28] = 32'h00a00393;
        ROM[29] = 32'h00060ab3;
        ROM[30] = 32'h00000b13;
        ROM[31] = 32'h007ac863;
        ROM[32] = 32'h407a8ab3;
        ROM[33] = 32'h001b0b13;
        ROM[34] = 32'hff5ff0ef;
        ROM[35] = 32'h00000b93;
        ROM[36] = 32'h007b4863;
        ROM[37] = 32'h407b0b33;
        ROM[38] = 32'h001b8b93;
        ROM[39] = 32'hff5ff0ef;
        ROM[40] = 32'h00000c13;
        ROM[41] = 32'h007bc863;
        ROM[42] = 32'h407b8bb3;
        ROM[43] = 32'h001c0c13;
        ROM[44] = 32'hff5ff0ef;

        ROM[45] = 32'h0385a223;
        ROM[46] = 32'h0375a023;
        ROM[47] = 32'h0165ae23;
        ROM[48] = 32'h0155ac23;

        ROM[49] = 32'hf45ff0ef;

    end

    always @(*) begin
        // Divide addr by 4 to get the instruction index (since addr is byte-addressed)
        instruction = ROM[addr[11:2]];  // Using bits [11:2] for word-aligned access
    end

endmodule
