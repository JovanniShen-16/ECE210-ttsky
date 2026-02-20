/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_vxm (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // All output pins must be assigned. If not used, assign to 0.
  assign uo_out  = ui_in + uio_in;  // Example: ou_out is the sum of ui_in and uio_in
  assign uio_out = 0;
  assign uio_oe  = 0;

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, clk, rst_n, 1'b0};

  //instantiate neurons
  wire [3:0] input_spikes; //each spike from the input layer is a bit in the 4 bit number, making them have an inherent weight
  wire [3:0] layer_spikes; //same for the first layer, except this time there are 4 neurons, each with a different weight

  //input layer
  lif01 (.current(ui_in[7:4]), .clk(clk), .rst_n(rst_n), .state(), .spike(input_spikes[3]));
  lif02 (.current(ui_in[3:0]), .clk(clk), .rst_n(rst_n), .state(), .spike(input_spikes[2]));

  //first layer
  lif11 (.current(input_spikes), .clk(clk), .rst_n(rst_n), .state(), .spike(layer_spikes[3]));
  lif12 (.current(input_spikes), .clk(clk), .rst_n(rst_n), .state(), .spike(layer_spikes[2]));
  lif13 (.current(input_spikes), .clk(clk), .rst_n(rst_n), .state(), .spike(layer_spikes[1]));
  lif14 (.current(input_spikes), .clk(clk), .rst_n(rst_n), .state(), .spike(layer_spikes[0]));

  //output layer
  lif31 (.current(layer_spikes), .clk(clk), .rst_n(rst_n), .state(), .spike(uo_out[7]));
  lif32 (.current(layer_spikes), .clk(clk), .rst_n(rst_n), .state(), .spike(uo_out[6]));


endmodule
