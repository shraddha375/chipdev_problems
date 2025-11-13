module model #(parameter DATA_WIDTH = 32, ADDR_WIDTH = 5) (
    input [DATA_WIDTH - 1:0] din,
    input [ADDR_WIDTH - 1:0] wad1,
    input [ADDR_WIDTH - 1:0] rad1, rad2,
    input                    wen1, ren1, ren2,
    input                    clk,
    input                    resetn,

    output logic [DATA_WIDTH - 1:0] dout1, dout2,
    output logic                    collision
);

    logic [DATA_WIDTH - 1:0] registers [31:0];
    
    always @(posedge clk) begin
        if (!resetn) begin
            for(int i = 0; i < 32; i++) begin
                registers[i] <= 'b0;
            end

            dout1     <=  'b0;
            dout2     <=  'b0;
            collision <= 1'b0;
        end
        else begin
            if (((wen1 && ren1) && (wad1 == rad1)) ||
                ((wen1 && ren2) && (wad1 == rad2)) ||
                ((ren1 && ren2) && (rad1 == rad2))) begin    
                
                dout1     <=  'b0;
                dout2     <=  'b0;
                collision <= 1'b1;
            end
            else begin
                if (wen1)
                    registers[wad1] <= din;
                
                if (ren1)
                    dout1 <= registers[rad1];
                else
                    dout1 <= 'b0;

                if (ren2)
                    dout2 <= registers[rad2];
                else
                    dout2 <= 'b0;
                
                collision <= 1'b0;
            end
        end
    end

endmodule
