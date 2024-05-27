#Student ID: 1113560
#Name: Jie-Luen Yang(Alan)
.globl __start
.data
  string_buffer: .space 1024
.rodata
  #open flags
  O_RDWR:  .word 0b0000100
  O_CREAT: .word 0b0100000
  #O_EXCL:  .word 0b1000000
  #pathname
  path: .asciz "C:/Users/Alanyang/yzu_code/Assembly/HW2/example.txt"
  msg1: .asciz "**The file descriptor number: "
  msg2: .asciz "**Program terminated normally."
.text
__start:

  #print message 1
  li a0, 4
  la a1, msg1
  ecall
  
  # Open the file
  li a0, 13
  la a1, path
  lw a2, O_RDWR  # load O_RDWR open flag
  lw t0, O_CREAT # load O_CREAT open flag
  or a2, a2, t0  # set a2 = O_RDWR | O_CREAT
  #or a2, a2, t1  # set a2 = O_RDWR | O_CREAT | O_EXCL
  ecall
  
  #move file descriptor to t3
  mv t3, a0
  
  #print file descriptor(in t3)
  li a0, 1
  mv a1, t3
  ecall
  
  #print newline
  li a0, 11
  li a1, '\n'
  ecall
  
  #read contents in the file
  li a0, 14
  mv a1, t3
  la a2, string_buffer
  li a3, 1024
  ecall
  
  #print contents
  print_loop:
    lb t5, 0(a2) #load a byte from the buffer
    beq t5,x0 ,print_end #If the byte is zero, we reach the end
    #print characters
    li a0, 11
    mv a1, t5
    ecall
    
    #increment the buffer pointer
    addi a2, a2, 1
    j print_loop
  
  print_end:
    #insert new line
    li a0, 11
    li a1, '\n'
    ecall
    
  #close file
  li a0, 16
  mv a1, t3
  ecall
  
  #print msg2
  li a0, 4
  la a1, msg2
  ecall
  
  #exit
  li a0, 10
  ecall