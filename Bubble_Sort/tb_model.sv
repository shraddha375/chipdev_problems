`timescale 1ns/1ps

module tb_sort;

    parameter BITWIDTH = 3;

    logic clk;
    logic resetn;
    logic sortit;
    logic [BITWIDTH-1:0] din;
    logic [8*BITWIDTH-1:0] dout;

    // Instantiate DUT (change name if needed)
    model #(.BITWIDTH(BITWIDTH)) dut (
    .din(din),
    .sortit(sortit),
    .clk(clk),
    .resetn(resetn),
    .dout(dout)
    );

    // Clock: 10ns period
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // waveform dump
    initial begin
        $dumpfile();
        $dumpvars();
    end

    // Stimulus sequence that matches the image timings
    initial begin
        // initialize
        din    = '0;
        sortit = 1'b0;
        resetn = 1'b0;
    
        @(posedge clk);
        din = 'h1;
        resetn = 1'b1;
    
        @(posedge clk);
        din = 'h2;
    
        @(posedge clk);
        din = 'h3;
    
        @(posedge clk);
        din = 'h4;
        sortit = 1'b1;
    
        @(posedge clk);
        din = 'h5;
    
        @(posedge clk);
        din = 'h7;
    
        repeat(2) @(posedge clk);
        din = 'h4;
    
        @(posedge clk);
        din = 'h1;
 
        @(posedge clk);
        din = 'h0;
    
        @(posedge clk);
        din = 'h2;
    
        @(posedge clk);
        din = 'h7;
    
        @(posedge clk);
        din = 'h0;
    
        $display("[%0t] Test finished", $time);
        $finish;
    end

endmodule
