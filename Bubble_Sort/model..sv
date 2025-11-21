module model #(parameter BITWIDTH = 3) (
    input [BITWIDTH - 1:0] din,
    input sortit,
    input clk,
    input resetn,
    output logic [8*BITWIDTH - 1:0] dout
    );

    logic [BITWIDTH - 1:0] mem[7:0];
    logic [2:0] ptr;
    logic [8*BITWIDTH - 1:0] temp_dout;
    logic [BITWIDTH - 1:0] temp_reg;

    always @(posedge clk) begin
        if (!resetn) begin
            dout <= 'b0;
            ptr <= 'b0;
            for (int i = 0; i < 8; i++)
                mem[i] <= '0;
        end
        else begin
            if(!sortit) begin
                mem[ptr] <= din;
                ptr <= ptr + 1;
                dout <= 'b0;
            end
            else begin
                dout <= temp_dout;
            end
        end
    end

    always @(*) begin
        if (sortit) begin
            for (int i = 7; i >= 1; i--) begin
                for (int j = 0; j < i; j++) begin
                    if (mem[j] > mem[j + 1]) begin
                        temp_reg = mem[j];
                        mem[j] = mem[j + 1];
                        mem[j + 1] = temp_reg;
                    end
                end
            end
            
            for (int k = 0; k < 8; k++) begin
              temp_dout[k*BITWIDTH +: BITWIDTH] = mem[7 - k];
            end

        end
        else begin
            temp_dout = 'b0;
        end
    end


endmodule
