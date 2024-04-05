##############################################################################################
# Title: Factorial Homework
# Name: Fang, Hao-Hsiang
# Student ID Number: s1113559
# (a). How many hours did you spend for this homework? 
# ANS: 5
# (b). Who has helped you solve this coding problem? 
# ANS: NO
# (c). Do you copy someone's code?
# If yes, give the name of code owners and the number of lines of the code you copy. 
# ANS: NO
##############################################################################################
.data
string_buffer: .space 256            # Allocate 256 bytes of space for string input
enterName: .string "\n Please enter your name(in English): "  # String for name input prompt
outName: .string "My name is: "                               # Prefix for outputting the name
studentIn: .string "\n Please enter your student ID number: " # String for student ID input prompt
studentOut: .string "My student ID number is: "               # Prefix for outputting the student ID
numIn: .string "\n Please enter a non-negative number (a negative for exit): " # Prompt for factorial number input
numout_1: .string "The result of "                            # Prefix for the factorial result output part 1
numout_2: .string "! is: "                                    # Prefix for the factorial result output part 2

.text
.globl __start
print_string:
    li      a0, 4      # System call number for printing a string
    ecall              # Perform the system call
    jr      ra         # Return to the caller

read_string:
    li      a0, 8      # System call number for reading a string
    la      a1, string_buffer # Load the address of the buffer
    li      a2, 255    # Maximum number of bytes to read
    ecall              # Perform the system call
    jr      ra         # Return to the caller

print_int:
    li      a0, 1      # System call number for printing an integer
    ecall              # Perform the system call
    jr      ra         # Return to the caller

read_int:
    li      a0, 5      # System call number for reading an integer
    ecall              # Perform the system call
    jr      ra         # Return to the caller

facto:
    addi    t2, t3, -1 # t2 = t3 - 1
    beq     t2, x0, done # If t2 == 0, jump to done
    mul     t1, t2, t1 # t1 = t2 * t1
    mv      t3, t2     # t3 = t2
    bge     t3, x0, facto # If t3 >= 0, loop to facto

done:
    la      a1, numout_1 # Load the address of numout_1
    jal     ra, print_string # Call print_string to print numout_1
    mv      a1, t4      # Move input number to a1
    jal     ra, print_int # Call print_int to print the input number
    la      a1, numout_2 # Load the address of numout_2
    jal     ra, print_string # Call print_string to print numout_2
    mv      a1, t1      # Move t1 (result) to a1
    jal     ra, print_int # Call print_int to print the factorial result
    j       loop        # Jump to loop

resultIs1:
    li      t0, 1       # Load the 1 into t0.
    mv      t1, t0      # Move t0 to output value register
    j       done        # Jump to done

exit:
    li      a0, 10     # System call number for exiting
    ecall              # Perform the system call

__start:
    # Printing name instructions
    la      a1, enterName
    jal     ra, print_string

    jal     ra, read_string

    # Printing name
    la      a1, outName
    jal     ra, print_string
    la      a1, string_buffer
    jal     ra, print_string

    # Printing student ID instructions
    la      a1, studentIn
    jal     ra, print_string

    jal     ra, read_string

    # Printing student ID
    la      a1, studentOut
    jal     ra, print_string
    la      a1, string_buffer
    jal     ra, print_string

    # Factorial calculation loop
    loop:
        la      a1, numIn
        jal     ra, print_string

        jal     ra, read_int
        mv      t3, a0    # Move input to t3
        mv      t4, a0    # Also save input to t4 for later use
        mv      t1, a0     # Initialize t1 to 1 for factorial calculation

        beq     t3, x0, resultIs1 # If t3 equals to 0, jump to label resultIs1.

        blt     t3, x0, exit    # Exit if input is less than 0

        j       facto     # Jump to start factorial calculation
