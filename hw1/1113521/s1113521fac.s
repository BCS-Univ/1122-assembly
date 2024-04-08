#################################################################################################
#Title:Factorial Homework
#Name:Chen  Shih-Chun
#Student ID Number:s1113521
#(a).How many hours did you spend for this homework?
#ANS:7 hours
#(b).Who has helped you solved this coding problem?
#ANS:NO
#(c).Do you copy someone's code?
#ANS:NO
#################################################################################################

.globl __start
.rodata
msg1:.string"#title : Computing n! with RISC-V ISA"
msg2:.string"#please enter your name(in english) :"
msg3:.string"#my name is:"
msg4:.string"#please enter  your student ID:"
msg12:.string"my studentID is :"
msg5:.string"#(a)How many hours did you spend for this homework?"
msg6:.string"#Ans:7"
msg7:.string"#(b)Who has helped you solve the coding problems?"
msg8:.string"#Ans:none"
msg9:.string"#(c)Do you copy someone’s code?"
msg10:.string"Ans:no"
msg11:.string"please enter a non-negative number(a negative for exit):"
msg13:.string"The result of "
msg14:.string"! "
msg15:.string"is "


.data
ouo: .space 256

.text
__start:
li a0,4
la a1,msg1  
ecall#print msg1 

li a0, 11
li a1, '\n'
ecall # change row

li a0,4
la a1,msg2  
ecall#print msg2

li a0, 11
li a1, '\n'
ecall # change row

li a0, 8
la a1, ouo
li a2, 32
ecall  #read a name

li a0, 4
la a1,msg3
ecall

li a0, 4
la a1, ouo
ecall  #print the name

li a0, 11
li a1, '\n'
ecall # change row

li a0,4
la a1,msg4
ecall #print msg4

li a0, 11
li a1, '\n'
ecall # change row

li a0,8
la a1,ouo
li a2,32 
ecall#read id

li a0,4
la a1,msg12
ecall

li a0,4
la a1,ouo
ecall#print id
 
li a0, 11
li a1, '\n'
ecall # change row
 
li a0,4
la a1,msg5
ecall#print msg5

li a0, 11
li a1, '\n'
ecall # change row

li a0,4
la a1,msg6
ecall#print msg6

li a0, 11
li a1, '\n'
ecall # change row

li a0,4
la a1,msg7
ecall#print msg7

li a0, 11
li a1, '\n'
ecall # change row

li a0,4
la a1,msg8
ecall#print msg8

li a0, 11
li a1, '\n'
ecall # change row

li a0,4
la a1,msg9
ecall#print msg9

li a0, 11
li a1, '\n'
ecall # change row

li a0,4
la a1,msg10
ecall#print msg10

li a0, 11
li a1, '\n'
ecall # change row

loop:
li a0,4
la a1,msg11
ecall#print msg11

li a0, 5
ecall
mv t3, a0  # 將 a0 的值存入 t3
blt t3,x0,exit#<0 exit
li t1,1
mv t4,t3
fac:
    beq t3, x0,end # 檢查 t3 是否等於零
    mul t2, t1, t3     # f(n) = f(n-1) * n 如果還沒到零
    mv t1, t2          # 將 f(n) 存入 f(n-1)
    addi t3, t3, -1     # 更新 f(n) = f(n-1) * n 的次數
    j fac
  
end:
    
    li a0,4
    la a1,msg13
    ecall
    
    mv a1,t4
    li a0,1
    ecall
    
    li a0,4
    la a1,msg14
    ecall
    
    li a0,4
    la a1,msg15
    ecall
    
    mv a1,t1
    li a0,1
    ecall  
    
    li a0, 11
    li a1, '\n'
    ecall # change row
    j loop  
exit:
li a0, 10
ecall





