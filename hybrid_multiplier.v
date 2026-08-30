`timescale 1ns/1ps

module hybrid_multiplier(
    input clk,
    input reset,
    input [1:0] a, b,
    output reg [3:0] product
);

    // Memristor instances
    wire memristor_out0, memristor_out1, memristor_out2, memristor_out3;

    memristor_model mem0(.clk(clk), .reset(reset), .voltage_input(a[0] & b[0]), .resistance_state(memristor_out0));
    memristor_model mem1(.clk(clk), .reset(reset), .voltage_input(a[0] & b[1]), .resistance_state(memristor_out1));
    memristor_model mem2(.clk(clk), .reset(reset), .voltage_input(a[1] & b[0]), .resistance_state(memristor_out2));
    memristor_model mem3(.clk(clk), .reset(reset), .voltage_input(a[1] & b[1]), .resistance_state(memristor_out3));

    // Memristor-influenced partial products
    wire pp0, pp1, pp2, pp3;

    assign pp0 = (a[0] & b[0]) & ~memristor_out0;
    assign pp1 = (a[0] & b[1]) & ~memristor_out1;
    assign pp2 = (a[1] & b[0]) & ~memristor_out2;
    assign pp3 = (a[1] & b[1]) & ~memristor_out3;

    // Declare sum and carry as registers for use inside always block
    reg sum1, carry1, carry2;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            product <= 4'b0000;
        end else begin
            // First addition stage
            sum1 <= pp0 ^ pp1;
            carry1 <= pp0 & pp1;

            // Second addition stage
            product[0] <= sum1;
            product[1] <= sum1 ^ pp2 ^ carry1;
            carry2 <= (sum1 & pp2) | (pp2 & carry1) | (sum1 & carry1);

            // Final outputs
           // product[2] <= carry2;
           // product[3] <= pp3;
	    product[2] <= pp3 ^ carry2;  
            product[3] <= pp3 & carry2;
        end
    end

endmodule