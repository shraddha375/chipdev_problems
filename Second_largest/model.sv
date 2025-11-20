module model #(parameter DATA_WIDTH = 32) (
    input clk,
    input resetn,
    input [DATA_WIDTH - 1:0] din,
    output logic [DATA_WIDTH - 1:0] dout
    );

    logic [DATA_WIDTH - 1:0] temp_reg;

    always @(posedge clk) begin
        if (!resetn) begin
            dout     <= 'b0;
            temp_reg <= 'b0;
        end
        else begin
            if (din >= temp_reg) begin
                temp_reg <= din;
                dout <= temp_reg;
            end
            else begin
                if (din >= dout) begin
                    dout <= din;
                end
            end
        end

    end

endmodule
