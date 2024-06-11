.section .rodata
# Open flags and file paths
O_RDWR: .word 0b00000100
path: .asciz "example.txt"
prompt_fd: .asciz "** The file descriptor number: "
prompt_num_integers: .asciz "\n** The number of integers contained in the file: "
prompt_sorted: .asciz "\n** The sorted integers are as follows:\n"
prompt_bfsorted: .asciz "\n** The unsorted intergers are as follows:\n"
prompt_end: .asciz "\n** Program is terminated normally."
endl: .asciz "\n"
student_id_name: .asciz "s1113559 Fang, Hao-Hsiang\n"

.section .data
# Array to be sorted and its length
array: .space 1024  # Array to store integers
array_len: .word 0  # Length of the array

.section .bss
# Buffer allocation
buffer: .space 1024

.section .text
.globl __start

print_string:
    # Print a string
    li a0, 4       # ecall code for print_str
    ecall          
    jr ra          # Return

print_number:
    # Print a number
    li a0, 1       # ecall code for print_int
    ecall          
    jr ra          # Return

open_file:
    # Open a file
    li a0, 13      # ecall code for open
    ecall          
    jr ra          # Return

read_file:
    # Read from a file
    li a0, 14      # ecall code for read
    ecall          
    jr ra          # Return

exit:
    # Exit the program
    li a0, 10      # ecall code for exit
    ecall          

convert_and_store:
    # Convert ASCII to integers and store in array
    la t1, buffer        # Load address of buffer
    la t2, array         # Load address of array
    li t3, 0             # Initialize current number
    li t4, 0             # Initialize sign indicator (0: positive, 1: negative)
    li t5, 0             # Initialize number of integers

convert_loop:
    lb t0, 0(t1)         # Load byte from buffer 
    beqz t0, end_convert # End of buffer check
    li t6, ' '
    beq t0, t6, store_number
    li t6, '\n'
    beq t0, t6, store_number
    li t6, '-'
    beq t0, t6, negative_sign

    li t6, '0'
    blt t0, t6, skip_char
    li t6, '9'
    bgt t0, t6, skip_char

    # Convert ASCII to integer
    li t6, 10
    mul t3, t3, t6
    li t6, '0'
    sub t0, t0, t6
    add t3, t3, t0
    j skip_char

store_number:
    #if the next element is space or \n, skip_char
    lb t6, -1(t1)
    #beq t6, t0, skip_char
    li t0, ' '
    beq t6, t0, skip_char
    li t0, '\n'
    beq t6, t0, skip_char

    # Store the current number
    beqz t4, store_positive
    sub t3, x0, t3  # If negative, take two's complement

store_positive:
    sw t3, 0(t2)   # Store number in array
    addi t2, t2, 4 # Increment array pointer
    li t3, 0       # Reset current number
    li t4, 0       # Reset sign indicator
    addi t5, t5, 1 # Increment number of integers
    j skip_char

negative_sign:
    li t4, 1       # Set sign indicator to negative
    j skip_char

skip_char:
    addi t1, t1, 1 # Move to next character
    j convert_loop

end_convert:
    la t6, array_len
    sw t5, 0(t6)   # Store number of integers
    jr ra          # Return

print_array:
    # Print the numbers in the array
    la t1, array        # Load address of array
    la t2, array_len    # Load address of array length
    lw t2, 0(t2)        # Load array length
    li t3, 0            # Initialize counter

print_loop:
    beq t3, t2, end_print  # If counter equals length, end print
    lw t0, 0(t1)           # Load current number
    mv a1, t0              # Move to a1 for printing
    li a0, 1               # ecall code for print_int
    ecall                  
    la a1, endl            # Load address of newline
    li a0, 4               # ecall code for print_str
    ecall                  
    addi t1, t1, 4         # Move to next number
    addi t3, t3, 1         # Increment counter
    j print_loop

end_print:
    jr ra                  # Return

bubble:
    # Print the numbers in the array
    la t1, array        # Load address of array
    la t2, array_len    # Load address of array length
    lw t2, 0(t2)        # Load array length
    li t3, 0            # i counter
    li t6, 0            # j counter

sort:
    beq t6, t2, end_print
    beq t3, t2, next_loop
    lw t4, 0(t1)        #load current number
    lw t5, 4(t1)        #n+1
    bge t4, t5 swap
    addi t1, t1, 4
    addi t3, t3, 1
    j sort

swap:
    sw t5, 0(t1)
    sw t4, 4(t1)
    addi t1, t1, 4
    addi t3, t3, 1
    j sort

next_loop:
    addi t6, t6, 1
    li t3, 0
    la t1, array
    j sort

__start:
    la a1, student_id_name
    li a0, 4        # ecall code for print_str
    ecall           


    la a1, path     # Load address of path
    lw a2, O_RDWR   # Load open flags
    jal open_file
    mv t0, a0       # Save file descriptor


    la a1, prompt_fd
    li a0, 4        # ecall code for print_str
    ecall           
    mv a1, t0       # Move file descriptor to a1
    li a0, 1        # ecall code for print_int
    ecall           
    la a1, endl     # Load address of newline
    li a0, 4        # ecall code for print_str
    ecall           


    mv a1, t0       # Move file descriptor to a1
    la a2, buffer   # Load address of buffer
    li a3, 1024     # Number of bytes to read
    jal read_file

    # convert and store as intergers
    jal convert_and_store

    # print totla num of elements (interger)
    la a1, prompt_num_integers
    li a0, 4        # ecall code for print_str
    ecall           
    la t0, array_len
    lw a1, 0(t0)    # Load number of integers
    li a0, 1        # ecall code for print_int
    ecall           
    la a1, endl     # Load address of newline
    li a0, 4        # ecall code for print_str
    ecall           

    la a1, prompt_bfsorted
    ecall
    jal print_array

    la a1, prompt_sorted
    li a0, 4        # ecall code for print_str
    ecall
    jal bubble         
    jal print_array

    # end
    la a1, prompt_end
    li a0, 4        # ecall code for print_str
    ecall           
    li a0, 10       # ecall code for exit
    ecall           
