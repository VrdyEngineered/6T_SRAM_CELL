`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.09.2025 22:21:27
// Design Name: 
// Module Name: SRAM_6T_tb
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


module SRAM_6T_tb;

  
     reg WL;          // wordline
    wire BL, BR;     // bitlines (bidirectional)

    // Internal drivers for bitlines (for writing)
    reg BL_driver, BR_driver;
    reg BL_en, BR_en;  // enable for drivers

    // Connect drivers to bitlines (only active during write)
    assign BL = (BL_en) ? BL_driver : 1'bz;
    assign BR = (BR_en) ? BR_driver : 1'bz;

    // Instantiate the SRAM cell
   SRAM_CELL6T uut (
        .WL(WL),
        .BL(BL),
        .BR(BR)
    );

    initial begin
        $dumpfile("sram_6t.vcd");   // waveform output
//        $dumpvars(0, SRAM_6T_tb);

        // Step 1: Write '1' into cell
        $display("Writing 1 into cell...");
        WL = 1;                // enable access
        BL_en = 1; BL_driver = 1;  // BL = 1
        BR_en = 1; BR_driver = 0;  // BR = 0
        #10;
        WL = 0;                // disable access
        BL_en = 0; BR_en = 0;  // release bitlines
        #10;

        // Step 2: Read from cell
        $display("Reading from cell...");
        WL = 1;                // enable access
        #10;
        $display("Bitlines during read: BL=%b BR=%b", BL, BR);
        WL = 0;                // disable access
        #10;

        // Step 3: Write '0' into cell
        $display("Writing 0 into cell...");
        WL = 1;
        BL_en = 1; BL_driver = 0;  // BL = 0
        BR_en = 1; BR_driver = 1;  // BR = 1
        #10;
        WL = 0;
        BL_en = 0; BR_en = 0;
        #10;

        // Step 4: Read again
        $display("Reading from cell...");
        WL = 1;
        #10;
        $display("Bitlines during read: BL=%b BR=%b", BL, BR);
        WL = 0;
        #10;

        $finish;
    end
endmodule
