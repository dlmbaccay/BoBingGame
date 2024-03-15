`timescale 1ns / 1ps

module BoBingScoring_tb;

    // parameters
    parameter CLK_PERIOD = 10; // clock period in ns

    // signals
    reg [2:0] D1, D2, D3, D4, D5, D6;
    wire P1, P2, P3, P4, P5, P6;

    // instantiate the module
    BoBingScoring uut (
        .D1(D1),
        .D2(D2),
        .D3(D3),
        .D4(D4),
        .D5(D5),
        .D6(D6),
        .P1(P1),
        .P2(P2),
        .P3(P3),
        .P4(P4),
        .P5(P5),
        .P6(P6)
    );
    
    // clock generation
    reg clk = 0;
    always #CLK_PERIOD clk = ~clk;

    // function to resetInputs
    task resetInputs;
    begin
        D1 = 3'b000;
        D2 = 3'b000;
        D3 = 3'b000;
        D4 = 3'b000;
        D5 = 3'b000;
        D6 = 3'b000;
    end
    endtask
    
    // test stimuli
    initial begin

    $display("\nBoBing Scoring Testbench\n");
    #10

    $display("Baccay | Del Mundo | Madrinan\n");
    #10

    $display("CSARCH1 Design Exercise 2\n");
    #10

    $display("Test Case      || P1, P2, P3, P4, P5, P6");
    #10;

    // test case 1: invalid
    D1 = 3'b100;
    D2 = 3'b100;
    D3 = 3'b001;
    D4 = 3'b111; // invalid
    D5 = 3'b111;
    D6 = 3'b000;
    #10;
    $display("Invalid        || %b   %b   %b   %b   %b   %b", P1,P2,P3,P4,P5,P6);

    resetInputs;
    // test case 2: quadruple 4s
    D1 = 3'b100;
    D2 = 3'b100;
    D3 = 3'b100;
    D4 = 3'b100;
    D5 = 3'b001;
    D6 = 3'b110; 
    #10;
    $display("Quadru 4s      || %b   %b   %b   %b   %b   %b", P1,P2,P3,P4,P5,P6);

    resetInputs;
    // test case 3: five of any kind
    D1 = 3'b101;
    D2 = 3'b100;
    D3 = 3'b101;
    D4 = 3'b101;
    D5 = 3'b101;
    D6 = 3'b101;
    #10;
    $display("Five of a kind || %b   %b   %b   %b   %b   %b", P1,P2,P3,P4,P5,P6);

    resetInputs;
    // test case 4: one of each number
    D1 = 3'b001;
    D2 = 3'b010;
    D3 = 3'b011;
    D4 = 3'b100;
    D5 = 3'b101;
    D6 = 3'b110;
    #10;
    $display("One of each    || %b   %b   %b   %b   %b   %b", P1,P2,P3,P4,P5,P6);

    resetInputs;
    // test case 5: three of a number AND two of another number
    D1 = 3'b001;
    D2 = 3'b001;
    D3 = 3'b001;
    D4 = 3'b010;
    D5 = 3'b010;
    D6 = 3'b010;
    #10;
    $display("Three-Three    || %b   %b   %b   %b   %b   %b", P1,P2,P3,P4,P5,P6);
    
    resetInputs;
    // test case 6: three 4-faced
    D1 = 3'b100;
    D2 = 3'b001;
    D3 = 3'b100;
    D4 = 3'b110;
    D5 = 3'b011;
    D6 = 3'b100;
    #10;
    $display("Three 4-Faced  || %b   %b   %b   %b   %b   %b", P1,P2,P3,P4,P5,P6);

    resetInputs;
    // test case 7: four 1-faced
    D1 = 3'b001;
    D2 = 3'b001;
    D3 = 3'b001;
    D4 = 3'b001;
    D5 = 3'b010;
    D6 = 3'b010;
    #10;
    $display("Four 1-Faced   || %b   %b   %b   %b   %b   %b", P1,P2,P3,P4,P5,P6);

    resetInputs;
    // test case 8: four 2-faced
    D1 = 3'b010;
    D2 = 3'b010;
    D3 = 3'b010;
    D4 = 3'b010;
    D5 = 3'b001;
    D6 = 3'b001;
    #10;
    $display("Four 2-Faced   || %b   %b   %b   %b   %b   %b", P1,P2,P3,P4,P5,P6);

    resetInputs;
    // test case 9: four 3-faced
    D1 = 3'b011;
    D2 = 3'b011;
    D3 = 3'b011;
    D4 = 3'b011;
    D5 = 3'b100;
    D6 = 3'b100;
    #10;
    $display("Four 3-Faced   || %b   %b   %b   %b   %b   %b", P1,P2,P3,P4,P5,P6);
    
    resetInputs;
    // test case 10: four 5-faced
    D1 = 3'b101;
    D2 = 3'b101;
    D3 = 3'b101;
    D4 = 3'b101;
    D5 = 3'b110;
    D6 = 3'b110;
    #10;
    $display("Four 5-Faced   || %b   %b   %b   %b   %b   %b", P1,P2,P3,P4,P5,P6);

    resetInputs;
    // test case 11: four 6-faced
    D1 = 3'b110;
    D2 = 3'b110;
    D3 = 3'b110;
    D4 = 3'b110;
    D5 = 3'b101;
    D6 = 3'b101;
    #10;
    $display("Four 6-Faced   || %b   %b   %b   %b   %b   %b", P1,P2,P3,P4,P5,P6);

    resetInputs;
    // test case 12: two 4-faced
    D1 = 3'b100;
    D2 = 3'b100;
    D3 = 3'b110;
    D4 = 3'b101;
    D5 = 3'b010;
    D6 = 3'b001;
    #10;
    $display("Two 4-Faced    || %b   %b   %b   %b   %b   %b", P1,P2,P3,P4,P5,P6);
    

    resetInputs;
    // test case 13: one 4-faced
    D1 = 3'b110;
    D2 = 3'b001;
    D3 = 3'b001;
    D4 = 3'b100;
    D5 = 3'b011;
    D6 = 3'b010;
    #10;
    $display("One 4-Faced    || %b   %b   %b   %b   %b   %b", P1,P2,P3,P4,P5,P6);
    
    resetInputs;
    // test case 14: no prize
    D1 = 3'b110;
    D2 = 3'b001;
    D3 = 3'b101;
    D4 = 3'b110;
    D5 = 3'b011;
    D6 = 3'b101;
    #10;
    $display("No Prize       || %b   %b   %b   %b   %b   %b\n", P1,P2,P3,P4,P5,P6);

    // finish sim
    $finish;
    end
endmodule

