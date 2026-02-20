`default_nettype none

module lif (
    input wire[3:0] value,
    input wire clk,
    input wire rst_n,
    output reg [3:0] state,
    output wire spike
)

    wire [7:0] next_state;
    reg [7:0] threshold;
    reg [7:0] beta;

    always @(posedge clk) begin
        if (!rst_n) begin
            state <= 0;
            threshold <= 128; // Example threshold
            beta <= d'10; // Example decay factor
        end else begin
            state <= next_state;
        end
    end

    assign next_state = current + beta * state;

    assign spike = (state >= threshold);

endmodule