
`timescale 1ns/1ps

module proposed_multiplier(
    input clk,
    input reset,
    input [1:0] a, b,
    output [3:0] product,
    output clk_gated_monitor,
    output input_changed_monitor
);
    
    wire clk_gated;
    wire [3:0] product_temp;
    
    // Clock gating module
    adaptive_gating gating_inst(
        .clk(clk),
        .reset(reset),
        .a(a),
        .b(b),
        .clk_gated(clk_gated),
        .input_changed_signal(input_changed_monitor)
    );
    
    // Hybrid multiplier with gated clock
    hybrid_multiplier hybrid_inst(
        .clk(clk_gated),
        .reset(reset),
        .a(a),
        .b(b),
        .product(product_temp)
    );
    
    // Output assignment
    assign product = product_temp;
    assign clk_gated_monitor = clk_gated;
    
endmodule