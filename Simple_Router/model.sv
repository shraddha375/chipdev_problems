module model #(parameter DATA_WIDTH = 32) (
    input  [DATA_WIDTH-1:0] din,
    input  din_en,
    input  [1:0] addr,
    output logic [DATA_WIDTH-1:0] dout0,
    output logic [DATA_WIDTH-1:0] dout1,
    output logic [DATA_WIDTH-1:0] dout2,
    output logic [DATA_WIDTH-1:0] dout3
    );
    
    //-----------------------
    // Implementation 1
    //-----------------------
  
    always @(*) begin
        if (!din_en) begin
            dout0 = 'b0;
            dout1 = 'b0;
            dout2 = 'b0;
            dout3 = 'b0;
        end
        else begin
            case(addr)
                2'b00: begin
                    dout0 = din;
                    dout1 = 'b0;
                    dout2 = 'b0;
                    dout3 = 'b0;
                end
                2'b01: begin
                    dout0 = 'b0;
                    dout1 = din;
                    dout2 = 'b0;
                    dout3 = 'b0;
                end
                2'b10: begin
                    dout0 = 'b0;
                    dout1 = 'b0;
                    dout2 = din;
                    dout3 = 'b0;
                end
                2'b11: begin
                    dout0 = 'b0;
                    dout1 = 'b0;
                    dout2 = 'b0;
                    dout3 = din;
                end
            endcase
        end
    end

    //-----------------------
    // Implementation 2
    //-----------------------
    /*
    always @(*) begin        
        dout0 = 'b0;
        dout1 = 'b0;
        dout2 = 'b0;
        dout3 = 'b0;
        
        if(din_en) begin
            case(addr)
                2'b00: dout0 = din;
                2'b01: dout1 = din;
                2'b10: dout2 = din;
                2'b11: dout3 = din;
            endcase
        end
    end
    */
    //-----------------------
    // Implementation 3
    //-----------------------
    /*
    assign dout0 = (din_en && (addr == 2'b00)) ? din : 'b0;
  	assign dout1 = (din_en && (addr == 2'b01)) ? din : 'b0;
  	assign dout2 = (din_en && (addr == 2'b10)) ? din : 'b0;
  	assign dout3 = (din_en && (addr == 2'b11)) ? din : 'b0;
    */
endmodule
