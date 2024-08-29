The Program Counter (PC) is a register that holds the address of the current or next instruction to be fetched in a RISC-V processor. The inputs and outputs of the PC module are as follows:

### Inputs
1. **Clock (`clk`)**
   - **Purpose:** The clock signal drives the updating of the PC on every clock edge.
   - **Operation:** The PC is updated on the rising or falling edge of the clock, depending on the design.

2. **Reset (`rst`)**
   - **Purpose:** Initializes or resets the PC to a known value, typically the start address of the program (e.g., 0x00000000).
   - **Operation:** When `rst` is asserted (usually active-high), the PC is set to the reset value, typically 0 or another predefined address.

3. **PC Source (`pc_src`)**
   - **Purpose:** Selects the source of the new PC value. It determines whether the PC should be incremented to the next sequential address or set to a branch/jump target.
   - **Operation:** This is a control signal, often implemented as a multiplexer selector, that chooses between different PC update sources (e.g., incremented PC, branch target, jump target).

4. **Next PC (`next_pc`)**
   - **Purpose:** Provides the address for the next instruction, typically the output of the PC incrementer or branch/jump logic.
   - **Operation:** This value is selected by `pc_src` and is used to update the PC register.

5. **Enable (`en`)** (Optional)
   - **Purpose:** Controls whether the PC should be updated or held constant (e.g., during pipeline stalls).
   - **Operation:** When `en` is asserted, the PC is updated; otherwise, it remains unchanged.

### Outputs
1. **Current PC (`pc_out`)**
   - **Purpose:** The current value of the PC, which is used as the address to fetch the next instruction from memory.
   - **Operation:** This value is output from the PC register and provided to the instruction memory.

### Summary:
- **Inputs:** Clock (`clk`), Reset (`rst`), PC Source (`pc_src`), Next PC (`next_pc`), Enable (`en`) (optional).
- **Outputs:** Current PC (`pc_out`).

### Typical Operation:
1. **Reset:** On reset (`rst` asserted), the PC is set to the reset value (e.g., 0x00000000).
2. **Normal Operation:** On each clock cycle, the PC is updated based on the value selected by `pc_src` (e.g., incremented PC or branch target).
3. **Stalling:** If `en` is deasserted, the PC holds its current value, effectively stalling the instruction fetch process.