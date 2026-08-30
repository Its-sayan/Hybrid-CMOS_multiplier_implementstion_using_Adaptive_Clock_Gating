
`timescale 1ns/1ps

module adaptive_gating(
    input clk,
    input reset,
    input [1:0] a, b,
    output reg clk_gated,
    output reg input_changed_signal
);
    
    reg [1:0] a_prev, b_prev;
    wire input_changed;
    
    // Detect input changes
    assign input_changed = (a != a_prev) || (b != b_prev);
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            a_prev <= 2'b00;
            b_prev <= 2'b00;
            clk_gated <= 1'b0;
            input_changed_signal <= 1'b0;
        end else begin
            // Store previous values
            a_prev <= a;
            b_prev <= b;
            
            // Gate clock when no input changes
            clk_gated <= input_changed;
            input_changed_signal <= input_changed;
        end
    end
    
endmodule