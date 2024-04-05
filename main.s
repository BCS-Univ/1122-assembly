##############################################################################################
#Title:Factorial Homework
#Name:Fang, Hao-Hsiang
#Student ID Number:s1113559
#(a).How many hours did you spend for this homework?
#ANS:5
#(b).Who has helped you solved this coding problem?
#ANS:NO
#(c).Do you copy someone's code?
#If yes give the name of code owners and the number of lines of the code you copy.
#ANS:NO
##############################################################################################
.data
string_buffer: .space 256
enterName: .string "\n Please enter your name(in English): "
outName: .string "My name is: "
studentIn: .string "\n Please enter your student ID number: "
studentOut: .string "My student ID number is: "
numIn: .string "\n \n Please enter a non-negative number (a negative for exit): "
numout_1: .string "The result of "
numout_2: .string "! is: "

.text
.globl __start
print_string:
    li      a0 4
    ecall
    jr      ra

read_string:
    li      a0 8
    la      a1 string_buffer
    li      a2 255
    ecall
    jr      ra

print_int:
    li      a0 1
    ecall
    jr      ra

read_int:
    li      a0 5
    ecall
    jr      ra

facto:
    addi    t2 t3 -1
    beq     t2 x0 done
    mul     t1 t2 t1
    mv      t3 t2
    bge     t3 x0 facto

done:
    la      a1 numout_1
    jal     ra print_string
    mv      a1 t4
    jal     ra print_int
    la      a1 numout_2
    jal     ra print_string
    mv      a1 t1
    jal     ra print_int
    j       loop

exit:
    li      a0 10
    ecall

exite:
    mv      a1 t3
    jal     ra print_int
    j       exit

__start:
    # print name instruction 
    la      a1 enterName
    jal     ra print_string

    jal     ra read_string

    # print name
    la      a1 outName
    jal     ra print_string
    la      a1 string_buffer
    jal     ra print_string

    # print id instruction
    la      a1 studentIn
    jal     ra print_string

    jal     ra read_string

    # print id
    la      a1 studentOut
    jal     ra print_string
    la      a1 string_buffer
    jal     ra print_string

    #-------------------
    #factorial
    loop:
        la      a1 numIn
        jal     ra print_string

        jal     ra read_int
        mv      t3 a0
        mv      t4 a0
        mv      t1 a0

        # exit if less then 0
        blt     t3 x0 exite

        j      facto