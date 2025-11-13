module tb_model();
    parameter DATA_WIDTH = 32;
    parameter ADDR_WIDTH = 5;
  
  	logic [DATA_WIDTH - 1:0] din;
  	logic [ADDR_WIDTH - 1:0] wad1;
  	logic [ADDR_WIDTH - 1:0] rad1, rad2;
    logic                    wen1, ren1, ren2;
    logic                    clk;
    logic                    resetn;

  	logic [DATA_WIDTH - 1:0] dout1, dout2;
    logic                    collision;
  
    model #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) dut (    
                                       .din(din),
                                       .wad1(wad1),
                                       .rad1(rad1),
                                       .rad2(rad2),
                                       .wen1(wen1),
                                       .ren1(ren1),
                                       .ren2(ren2),
                                       .clk(clk),
                                       .resetn(resetn),
                                       .dout1(dout1),
                                       .dout2(dout2),
                                       .collision(collision));
    always #5 clk = ~clk;  
  
    initial begin
        // Initialize signals
    	clk = 1'b0;
    	resetn = 1'b0;
    	din = 'b0;
    	wad1 = 'b0; rad1 = 'b0; rad2 = 'b0;
    	wen1 = 'b0; ren1 = 'b0; ren2 = 'b0;
      
        // Apply reset
      	repeat(3) @(posedge clk);
    	resetn = 1;

    	// Write to address 5
    	@(posedge clk);
    	din = 32'hA5A5_0001;
    	wad1 = 5'd5;
    	wen1 = 1;
    	ren1 = 0; ren2 = 0;
    	@(posedge clk);
    	wen1 = 0;
  
    	// Read from address 5
    	@(posedge clk);
    	rad1 = 5'd5;
    	ren1 = 1;
    	@(posedge clk);
        ren1 = 0;
   	
      	// Read from address 10
    	@(posedge clk);
    	rad1 = 5'd10;
    	ren1 = 1;
      	@(posedge clk);
      
    	// Two reads simultaneously
    	@(posedge clk);
    	rad1 = 5'd5;
    	rad2 = 5'd10;
    	ren1 = 1;
    	ren2 = 1;
    	@(posedge clk);
    
    	// Collision: read same address on both ports
    	@(posedge clk);
    	rad1 = 5'd5;
    	rad2 = 5'd5;
    	ren1 = 1;
    	ren2 = 1;
    	@(posedge clk);

    	// Collision: write + read same address
    	@(posedge clk);
    	wad1 = 5'd5;
    	rad1 = 5'd5;
    	din = 32'h12345678;
    	wen1 = 1;
    	ren1 = 1;
    	ren2 = 0;
    	@(posedge clk);
        ren1 = 0;
        @(posedge clk);
        ren1 = 1;
        wen1 = 0;

    	// Finish
        repeat(5) @(posedge clk);
    	$finish;
    end
  
    initial begin
        $dumpfile("dump.vcd"); 
        $dumpvars;  
    end
  	
endmodule
