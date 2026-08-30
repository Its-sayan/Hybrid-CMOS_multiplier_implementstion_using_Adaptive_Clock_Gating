`timescale 1ns/1ps

module conventional_multiplier(
    input [1:0] a, b,
    output [3:0] product
);
    
    //2x2 multiplier logic
    wire pp0, pp1, pp2, pp3;
    wire sum1, carry1, carry2;
    
    // Partial products
    assign pp0 = a[0] & b[0];
    assign pp1 = a[0] & b[1];
    assign pp2 = a[1] & b[0];
    assign pp3 = a[1] & b[1];
    
    // First adder: pp0 + pp1
    assign sum1 = pp0 ^ pp1;
    assign carry1 = pp0 & pp1;
    
    // Second adder: sum1 + pp2 + carry1
    assign carry2 = (sum1 & pp2) | (pp2 & carry1) | (sum1 & carry1);
    
    // Output assignment FOR 2x2 MULTIPLIER
    assign product[0] = sum1;
    assign product[1] = sum1 ^ pp2 ^ carry1;
    assign product[2] = pp3 ^ carry2;    // 1
    assign product[3] = pp3 & carry2;    // 2
    
endmodule