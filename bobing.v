
module BoBingScoring(
    input [2:0] D1, D2, D3, D4, D5, D6, // 3-bit inputs for each die
    output reg P1, P2, P3, P4, P5, P6, // Outputs for each prize
    output reg Invalid // Output for invalid dice detection
);

// integer array face_counts 
integer face_counts[0:6];
reg [2:0] D[6:1]; 

// function to count number of each face
always @(*) begin

    // assign default values to the face counts
    face_counts[0] = 0;
    face_counts[1] = 0;
    face_counts[2] = 0;
    face_counts[3] = 0;
    face_counts[4] = 0;
    face_counts[5] = 0;
    face_counts[6] = 0;

    // assign the dice to an array
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

    // assign default values to the prizes
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
        P3 = 0; 
        P4 = 0;
        P5 = 0;
        P6 = 0;
    end

    // third prize (only checks if first and second prize conditions weren't met)
    else if (face_counts[4] == 3) begin
        P3 = 1;
        P4 = 0;
        P5 = 0;
        P6 = 0;
    end

    // fourth prize (only checks if first, second, and third prize conditions weren't met)
    else if (face_counts[1] == 4 || face_counts[2] == 4 || face_counts[3] == 4 || face_counts[5] == 4 || face_counts[6] == 4) begin
        P4 = 1;
        P5 = 0;
        P6 = 0;
    end

    // fifth prize (only checks if first, second, third, and fourth prize conditions weren't met)
    else if (face_counts[4] == 2) begin
        P5 = 1;
        P6 = 0;
    end

    // sixth prize (Since it's lowest priority, an 'else' suffices)
    else if (face_counts[4] == 1) begin
        P6 = 1; // Or any other condition for P6
    end
end

endmodule

// first prize: four 4-of-a-kind OR five of any number
// second prize: one of each number OR (three of a number AND three of another number)
// third prize: three 4-of-a-kind AND any number for the three remaining dice
// fourth prize: four of the same number except 4-of-a-kind
// fifth prize: two 4-of-a-kind AND any number for the four remaining dice
// sixth prize: one 4-of-a-kind AND any number for the five remaining dice