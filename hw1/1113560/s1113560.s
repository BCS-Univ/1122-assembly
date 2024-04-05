#################################################################################################
#Title:Factorial Homework
#Name:Jie-Luen Yang
#Student ID Number:s1113560
#(a).How many hours did you spend for this homework?
#ANS:5 hours
#(b).Who has helped you solved this coding problem?
#ANS:NO
#(c).Do you copy someone's code?
#If yes, give the name of code owners and the number of lines of the code you copy.
#ANS:NO
#################################################################################################
.globl __start
.data
string_buffer: .space 256 #Allocate the maximum space for input string
msg1: .string "Please enter your name(in English): "
msg2: .string "My name is: "
msg3: .string "Please enter your student ID number: "
msg4: .string "My student ID number is: "
msg5: .string "Please enter a non-negative number (a negative for exit): "
msg6: .string "The result of "
msg7: .string "! is: "
.text
__start:

# Print msg1
li a0, 4
la a1, msg1
ecall

# Read name input
li a0, 8
la a1, string_buffer  # Use a buffer to store the user input
li a2, 255     #Tell system the biggest length
ecall

# Print msg2
li a0, 4
la a1, msg2
ecall

# Print name input
li a0, 4
la a1, string_buffer
ecall

#Print msg3
li a0, 4
la a1, msg3
ecall

#Read ID input
li a0, 8
la a1, string_buffer
li a2, 255
ecall

#Print msg4
li a0, 4
la a1, msg4
ecall

#Print ID input
li a0, 4
la a1, string_buffer
ecall

#Print msg5 and it's a loop
Loop:
li t1, 1 #store factorial(1) == 1
li a0, 4
la a1, msg5
ecall

#Read num input 
li a0, 5
ecall

#move input num(a0) to t3
mv t3, a0

#check condition: if t3 is negative(less than 0), exit the program
blt t3, x0, exit

#Print msg6
li a0, 4
la a1, msg6
ecall

#Print num(in t3)
li a0, 1
mv a1, t3
ecall

#Factorial
fac_recursive:
beq t3, x0, finish # when t3 reaches 0, go to the finish branch
mul t2, t1, t3 
addi t3, t3, -1
mv t1, t2
bge t3, x0, fac_recursive

finish:
#Print msg7
li a0, 4
la a1, msg7
ecall

#Print result
li a0, 1
mv a1, t1
ecall

#Print new line
li a0, 11
li a1, '\n'
ecall

j Loop

# Exit the program
exit:
li a0, 10
ecall