`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.09.2025 21:37:49
// Design Name: 
// Module Name: SRAM_CELL6T
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module SRAM_CELL6T(
     input wire WL,        // Wordline (controls access transistors)
    inout wire BL, BR     // Bitlines (BL and BR are complementary)
    );
    // Define power and ground rails
    supply1 Vdd;   // acts like logic '1'
    supply0 Gnd;   // acts like logic '0'

    // Internal storage nodes
    wire Q, Qbar;

    // Cross-coupled inverters
    // Inverter 1
    pmos p1(Q, Vdd, Qbar);   // PMOS: drain=Q, source=Vdd, gate=Qbar
    nmos n1(Q, Gnd, Qbar);   // NMOS: drain=Q, source=Gnd, gate=Qbar

    // Inverter 2
    pmos p2(Qbar, Vdd, Q);   // PMOS: drain=Qbar, source=Vdd, gate=Q
    nmos n2(Qbar, Gnd, Q);   // NMOS: drain=Qbar, source=Gnd, gate=Q

    // Access transistors controlled by Wordline
    nmos n3(Q, BL, WL);      // Q <-> BL when WL=1
    nmos n4(Qbar, BR, WL);   // Qbar <-> BR when WL=1
endmodule
