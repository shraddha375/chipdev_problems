`timescale 1ns/1ps

module tb;

    parameter DATA_WIDTH = 32;

    // DUT inputs
    logic [DATA_WIDTH-1:0] din;
    logic din_en;
    logic [1:0] addr;

    // DUT outputs
    logic [DATA_WIDTH-1:0] dout0, dout1, dout2, dout3;

    // Instantiate DUT
    model #(DATA_WIDTH) dut (
        .din(din),
        .din_en(din_en),
        .addr(addr),
        .dout0(dout0),
        .dout1(dout1),
        .dout2(dout2),
        .dout3(dout3)
    );

    initial begin
        $dumpfile();
        $dumpvars();

        // Test 1: din_en = 0 → All outputs must be 0
        din = 32'hAAAA_AAAA;
        din_en = 0;
        addr = 2'b00;
        #10;
        $display("T1: Outputs = %h %h %h %h", dout0, dout1, dout2, dout3);

        // Test 2: addr = 00 → dout0 gets data
        din_en = 1;
        addr = 2'b00;
        din = 32'h1111_0000;
        #10;
        $display("T2: dout0=%h (expected), others=%h %h %h",
                 dout0, dout1, dout2, dout3);

        // Test 3: addr = 01 → dout1 gets data
        addr = 2'b01;
        din = 32'h2222_0000;
        #10;
        $display("T3: dout1=%h (expected), others=%h %h %h",
                 dout1, dout0, dout2, dout3);

        // Test 4: addr = 10 → dout2 gets data
        addr = 2'b10;
        din = 32'h3333_0000;
        #10;
        $display("T4: dout2=%h (expected), others=%h %h %h",
                 dout2, dout0, dout1, dout3);

        // Test 5: addr = 11 → dout3 gets data
        addr = 2'b11;
        din = 32'h4444_0000;
        #10;
        $display("T5: dout3=%h (expected), others=%h %h %h",
                 dout3, dout0, dout1, dout2);

        // Test 6: din_en = 0 again → everything must go back to zero
        din_en = 0;
        #10;
        $display("T6: Outputs after disable = %h %h %h %h",
                 dout0, dout1, dout2, dout3);

        $finish;
    end

endmodule
