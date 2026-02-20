`default_nettype none

module lif (
    input wire[3:0] current,
    input wire clk,
    input wire rst_n,
    output reg [3:0] state,
    output wire spike
);

    wire [3:0] next_state;
    reg [3:0] threshold;
    reg [3:0] beta;

    always @(posedge clk) begin
        if (!rst_n) begin
            state <= 0;
            threshold <= 4'd8; // Example threshold
            beta <= 4'd2;
        end else begin
            state <= next_state;
        end
    end

    wire [7:0] full_calc = current + (beta * state);
    assign next_state = full_calc[3:0];

    assign spike = (state >= threshold);

endmodule