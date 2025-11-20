`timescale 1ns/1ps

module tb_model();

    parameter DATA_WIDTH = 32;

    logic clk;
    logic resetn;
    logic [DATA_WIDTH-1:0] din;
    logic [DATA_WIDTH-1:0] dout;

    // DUT
    model #(DATA_WIDTH) dut (
        .clk(clk),
        .resetn(resetn),
        .din(din),
        .dout(dout)
    );

    // Clock: 10ns
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Main stimulus
    initial begin
        // ------------------------------
        // Example 1 Sequence
        // ------------------------------
        $display("=== Running Example 1 ===");
      
        din = 32'h2;
        resetn = 0;

        @(posedge clk);
        resetn = 1;
      
        @(posedge clk);
        din = 32'h6;
      
        @(posedge clk);
        din = 32'h0;
      
        @(posedge clk);
        din = 32'he;
      
        @(posedge clk);
        din = 32'hc;
      
        @(posedge clk);
        din = 32'h0;
        resetn = 0;
      
        @(posedge clk);
        din = 32'h1;
        resetn = 1;
      
        @(posedge clk);
        din = 32'h2;
      
        // ------------------------------
        // Example 2 Sequence
        // ------------------------------
        $display("=== Running Example 2 ===");
      
        @(posedge clk);
        resetn = 0;
        din = 32'h0;
      
        @(posedge clk);
        resetn = 1;
        din = 32'h1;
      
        @(posedge clk);
        din = 32'h2;
      
        @(posedge clk);
        din = 32'h3;
      
        repeat(3) @(posedge clk);

        $finish;
    end

  
    initial begin
        $dumpfile("dump.vcd"); 
        $dumpvars;
    end

endmodule
