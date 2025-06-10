// Initialize values in registers using preset variables
@R0
D=M          // D = RAM[0], which is R0 (first memory location)
@R1
M=D          // RAM[1] = D
@1
D=A          // D = 1 (constant)
@R1
M=D+M        // RAM[1] = RAM[1] + 1

@R2
M=D          // RAM[2] = 1 (initialized value)

// Simple loop: Count down from a value in R2 and increment R3
@R2
D=M          // D = RAM[2] (value to count down)
@END
D;JEQ        // If D == 0, jump to END

// Decrement D and store back in R2
@R2
D=M          // D = RAM[2]
@ONE
D=D-1        // Subtract 1
@R2
M=D          // Store D back in R2

// R3 = R1 + (R2 * 2)
@R2
D=M          // D = RAM[2]
@R2DOUBLE
0;JMP        // Jump to calculate 2 * R2

(R2DOUBLE)
@R2
D=M          // D = RAM[2]
D=D+M        // Valid: D = 2 * RAM[2]
@R3
M=D          // Store 2 * RAM[2] in R3

// Nested Loop: Count down R4 while summing R3 values
@R4
D=M          // D = RAM[4] (initial value)
@OUTEREND
D;JEQ        // If D == 0, jump to OUTEREND

// Decrement R4 and store back in R4
@R4
D=M          // D = RAM[4]
@ONE
D=D-1        // Subtract 1
@R4
M=D          // Store D back in R4

// Inner loop: Decrement R5 until zero, adding to R3
@R5
D=M          // D = RAM[5]
@INNEREND
D;JEQ        // If D == 0, jump to INNEREND

// Decrement R5 and add to R3
@R5
D=M          // D = RAM[5]
@ONE
D=D-1        // D = R5 - 1
@R5
M=D          // Store back in R5
@R3
D=M          // D = RAM[3]
@ONE
D=D+1        // Increment D by 1
@R6
M=D          // R6 = R3 + 1

// Continue inner loop
@R5
D=M          // D = R5
@INNERLOOP
D;JNE        // If R5 != 0, jump to INNERLOOP

(INNEREND)

// End inner loop, check R4 again
@R4
D=M          // D = RAM[4]
@OUTERLOOP
D;JNE        // If R4 != 0, jump to OUTERLOOP

(OUTEREND)

// Final check: if R6 == 10, jump to HALT
@R6
D=M          // D = RAM[6]
@TEN
D=D-A        // Subtract 10 from D
@HALT
D;JEQ        // If D == 0, jump to HALT

(TEN)
@10
D=A          // Load constant 10 into D

// Simple addition: R7 = R1 + R3 + R6
@R1
D=M          // D = RAM[1]
@R3
D=D+M        // D = R1 + R3
@R6
D=D+M        // D = R1 + R3 + R6
@R7
M=D          // Store result in R7

// Infinite loop to halt program
(HALT)
@HALT
0;JMP        // Halt by jumping to itself

(ONE)
@1
D=A          // Constant 1
