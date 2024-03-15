/**
*   BoBingScoring Module
*   -   This module is used to score the dice in the game of BoBing
*   -   The module takes in 6 3-bit inputs, each representing a die
*   -   The module outputs 6 1-bit outputs, each representing a prize
*   -   Optionally, the module also outputs a 1-bit output for invalid dice detection
*   -   The module uses a priority-based approach to assign prizes
*   -   The priority of the prizes is as follows:
*       1. Invalid Dice:    If any die is not in the range of 1-6
*       2. First Prize:     Four 4-of-a-kind or Five of any number
*       3. Second Prize:    One of each number or Three of a number and Three of another number
*       4. Third Prize:     Three 4-of-a-kind and any number for the three remaining dice
*       5. Fourth Prize:    Four of the same number except 4-of-a-kind
*       6. Fifth Prize:     Two 4-of-a-kind and any number for the four remaining dice
*       7. Sixth Prize:     One 4-of-a-kind and any number for the five remaining dice
*   -   If a prize condition is met, the lower priority prizes are reset
*   -   The prizes are assigned to the output reg variables
*   -   The module also includes an always block for input validation and prize checking
*/
module BoBingScoring(
    input [2:0] D1, D2, D3, D4, D5, D6, // 3-bit inputs for each die
    output reg P1, P2, P3, P4, P5, P6, // Outputs for each prize
    output reg Invalid // Output for invalid dice detection
);

/**
*   Variable Declarations
*   -   face_counts: array to store the number of each face
*   -   D: array to store the dice for counting
*/
integer face_counts[0:6];
reg [2:0] D[6:1]; 

/**
*   Always Block
*   -   This block is used to check the dice and assign prizes
*   -   The block is triggered by any change in the input dice
*/
always @(*) begin

    // reset the face counts
    face_counts[0] = 0;
    face_counts[1] = 0;
    face_counts[2] = 0;
    face_counts[3] = 0;
    face_counts[4] = 0;
    face_counts[5] = 0;
    face_counts[6] = 0;

    // assign the dice to the array
    D[1] = D1;
    D[2] = D2;
    D[3] = D3;
    D[4] = D4;
    D[5] = D5;
    D[6] = D6;

    // count the number of each face
    for (integer i = 1; i <= 6; i = i + 1) begin
        if (D[i] >= 1 && D[i] <= 6) begin
            face_counts[D[i]]++;
        end else if (D[i] == 0 || D[i] == 7) begin
            face_counts[0]++;
        end
    end

    // reset the prizes
    P1 = 0;
    P2 = 0;
    P3 = 0;
    P4 = 0;
    P5 = 0;
    P6 = 0;

    // check for invalid dice
    if (face_counts[0] > 0) begin
        P1 = 1;
        P2 = 1;
        P3 = 1;
        P4 = 1;
        P5 = 1;
        P6 = 1;
    end 

    // first prize (only checks if invalid dice condition wasn't met)
    else if ((face_counts[4] == 4)
        || (face_counts[1] == 5) || (face_counts[2] == 5) || (face_counts[3] == 5) || (face_counts[5] == 5) || (face_counts[6] == 5)
    ) begin
        P1 = 1;
        P2 = 0; // Reset lower priority prizes
        P3 = 0; 
        P4 = 0; 
        P5 = 0; 
        P6 = 0; 
    end

    // second prize (only checks if first prize condition wasn't met)
    else if (
        ((face_counts[1] == 1) && (face_counts[2] == 1) && (face_counts[3] == 1) && (face_counts[4] == 1) && (face_counts[5] == 1) && (face_counts[6] == 1)) ||
        ((face_counts[1] == 3 && face_counts[2] == 3) || (face_counts[1] == 3 && face_counts[3] == 3) || (face_counts[1] == 3 && face_counts[4] == 3) || (face_counts[1] == 3 && face_counts[5] == 3) || (face_counts[1] == 3 && face_counts[6] == 3) ||
        (face_counts[2] == 3 && face_counts[3] == 3) || (face_counts[2] == 3 && face_counts[4] == 3) || (face_counts[2] == 3 && face_counts[5] == 3) || (face_counts[2] == 3 && face_counts[6] == 3) ||
        (face_counts[3] == 3 && face_counts[4] == 3) || (face_counts[3] == 3 && face_counts[5] == 3) || (face_counts[3] == 3 && face_counts[6] == 3) ||
        (face_counts[4] == 3 && face_counts[5] == 3) || (face_counts[4] == 3 && face_counts[6] == 3) ||
        (face_counts[5] == 3 && face_counts[6] == 3)) 
    ) begin
        P2 = 1; 
        P3 = 0; // Reset lower priority prizes
        P4 = 0;
        P5 = 0;
        P6 = 0;
    end

    // third prize (only checks if first and second prize conditions weren't met)
    else if (face_counts[4] == 3) begin
        P3 = 1;
        P4 = 0; // Reset lower priority prizes
        P5 = 0;
        P6 = 0;
    end

    // fourth prize (only checks if first, second, and third prize conditions weren't met)
    else if (face_counts[1] == 4 || face_counts[2] == 4 || face_counts[3] == 4 || face_counts[5] == 4 || face_counts[6] == 4) begin
        P4 = 1;
        P5 = 0; // Reset lower priority prizes
        P6 = 0;
    end

    // fifth prize (only checks if first, second, third, and fourth prize conditions weren't met)
    else if (face_counts[4] == 2) begin
        P5 = 1;
        P6 = 0; // Reset lower priority prizes
    end

    // sixth prize (Since it's lowest priority, an 'else' suffices)
    else if (face_counts[4] == 1) begin
        P6 = 1;
    end
end

endmodule