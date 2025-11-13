Implement a programmable bitwidth, 32-word 2-read 1-write (2R1W) register file (RF).

The RF has 32 entries, each of which being a DATA_WIDTH-bit binary word.  The input word din is written to one of the entries of the RF by using the write address port wad1 and asserting signal wen1.  Entries are read from the RF by selecting the addresses and asserting the ren1 and/or ren2 signals.  The RF must support up to three operations per clock cycle, that is, two reads and one write;  no operations (NOP), one, and two operations must be also supported.

The default value of both dout1 and dout2 is zero.  If, at the rising edge of the clock, one of the read-enable ports is deasserted, then it is expected that its respective data-output port produces the default value (zero).  If one tries to read from an address that has never been written to, then dout1 and/or dout2 produce zero.

RF's output port collision = 1 when at least two out of three input addresses are equal, and collision = 0 otherwise.  That is, the RF must flag when one tries to write to and read from the same address (wad1 = rad1 or wad1 = rad2), or attempts to read from the same address using both read ports (rad1 or wad1 = rad2).
Input and Output Signals

    din - Input data port
    wad1 - Write input address 1
    rad1 - Read input address 1
    rad2 - Read input address 2
    wen1 - Write-enable signal 1
    ren1 - Read-enable input signal 1
    ren2 - Read-enable input signal 2
    clk - Clock signal
    resetn - Synchronous, active-low, reset signal
    dout1 - Output data port 1
    dout2 - Output data port 2
    collision - Indicates collisions among read & write addresses

Output signals during reset

    dout1 - 0
    dout2 - 0
    collision - 0

Example

The example below shows the RF is in reset mode at the very first cycle.  Then, a array of write operations is performed in multiple addresses.  Outputs dout1, dout2, and collision are all zero as there were not any read operations yet.  Next, a couple of reads are performed.  The last read operation was not valid because both rad1 and rad2 point to the same location.  In this case, dout1 and dout2 are zero whereas collision becomes one to indicate an address collision occurred.
<img width="766" height="573" alt="image" src="https://github.com/user-attachments/assets/0e16fb68-df3e-478f-8b95-6aa262684ea1" />
