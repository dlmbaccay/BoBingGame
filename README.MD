# Bo Bing Game

- The aim of this Verilog design project is to develop a module that accurately calculates the scores in a Bo Bing game based on the rolled dice values. Bo Bing is a traditional Chinese dice game where players roll six dice and earn prizes based on specific combination of dice values that they achieve.The module must determine the appropriate prize from 1st through 6th following the official Bo Bing rules.

### Design Phase

The group’s design utilizes a priority-based scoring system to reflect the rules of Bo Bing, where higher priority prizes take precedence.
1. Invalid Dice
- Any dice with a value outside the range of 1 to 6 is marked invalid.
-  If any of the dice are invalid, all lights illuminate (P1 - P6).
2. First Prize
- Achieved with four instances of 4-faced or five of any single number.
3. Second Prize:
- Achieved with one instance of each number (1-6) or a combination of three
of a number and three of another number.
4. Third Prize
- Achieved with three instances of 4–faced.
5. Fourth Prize
- Achieved with four instances of the same number (excluding 4-faced).
6. Fifth Prize
- Achieved with two instances of 4-faced.
7. Sixth Prize
- Achieved with a single instance of 4-faced.

### Verilog Module Implementation

- The Verilog implementation of the design project was split into two files, one being the module itself, and the other serving as a testbench.

```verilog
module BoBingScoring(
    input [2:0] D1, D2, D3, D4, D5, D6, // 3-bit inputs for each die 
    output reg P1, P2, P3, P4, P5, P6, // Outputs for each prize 
    output reg Invalid // Output for invalid dice detection
);
```

- The main BoBingScoring Module takes in 6 3-bit inputs, each representing a die; 6 1-bit outputs, each representing a prize, and an unused 1-bit output for invalid dice detection. The group took it upon themselves to include the invalid dice detection within the prize checking of which rendered the latter parameter not to be used anymore.

```verilog
integer face_counts[0:6];
reg [2:0] D[6:1];
```

- Two more variable declarations, in face_counts and D were done within the module, which acted as helper variables in achieving correct outputs for the input validation and prize checking. The variable face_counts is an array to store the number of each face, whilst the variable D is an array to store the dice for counting. Both of these variables are crucial in the pre-processing of the parameters taken in by the module.

- The face counting and prize checking were done within an always block which triggers any time the input dice is changed.

```verilog
// count the number of each face
for (integer i = 1; i <= 6; i = i + 1) begin
    if (D[i] >= 1 && D[i] <= 6) begin
        face_counts[D[i]]++;
    end else if (D[i] == 0 || D[i] == 7) begin
        face_counts[0]++;
    end
end
```

- The first process done within the always block is in checking how many faces of each number occurred in the 6 dice rolled by the player. This is processed through a for-loop to optimally retrieve the correct amount of occurred faces in a 6-die roll, ensuring that whatever will be processed by the prize checking is correct.

```verilog
// check for invalid dice
if (face_counts[0] > 0) begin
    P1 = 1;
    P2 = 1;
    P3 = 1;
    P4 = 1;
    P5 = 1;
    P6 = 1;
end
```

- The first priority in the priority-based scoring system explained above is for checking invalid dice. This is essentially the input validation process wherein if there are any 000 or 111 inputs present in the 6-die roll, that round of rolls will be deemed invalid and all prizes will be lit up or assigned the value of 1.

```verilog
// first prize (only checks if invalid dice condition wasn't met)
else if ((face_counts[4] == 4)
    || (face_counts[1] == 5) || (face_counts[2] == 5) ||
(face_counts[3] == 5) || (face_counts[5] == 5) || (face_counts[6] ==
5)
) begin
P1 = 1;
P2 = 0; // Reset lower priority prizes P3 = 0;
P4 = 0;
P5 = 0;
P6 = 0;
end
```

- If there are no invalid inputs detected, the prize checking will commence, which will now validate if the criteria for the first prize is met. It is worth mentioning that when the first prize criteria is met, lower priority prizes are reset or assigned the value of 0, to avoid duplicate prizes – which is technically barred as the prize checking will stop once a higher priority prize is met.

- This process for the prize checking goes all the way down to the last possible prize, of which afterwards, then stops the checking. If the round of 6-die roll doesn’t manage to get any prizes, outputs P1 to P6 are assigned the value of 0.