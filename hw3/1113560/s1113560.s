#Student ID: 1113560
#Name: Jie-Luen Yang(Alan)
.globl __start
.data
  string_buffer: .space 1024
  int_buffer: .space 1024

.rodata
  #open flags
  O_RDWR: .word 0b0000100
  O_CREAT: .word 0b0100000
  path: .asciz "example.txt"
  msg1: .asciz "** The number of integers contained in the file: "
  msg2: .asciz "** The sorted integers are as follows:"
  msg3: .asciz "** Program terminated normally."
.text
__start:
  #open the file
  li a0, 13
  la a1, path
  lw a2, O_RDWR
  lw t0, O_CREAT
  or a2, a2, t0
  ecall

  #move file descriptor to t3
  mv t3, a0

  #read the file
  li a0, 14   # ecall code
  mv a1, t3    # file descriptor
  la a2, string_buffer # buffer address
  li a3, 1024   # number of bytes to read
  ecall
  #initialize the integer counter
  li x18, 0
  #initialize the previous character flag
  li x19, 0
  #initialize the newline flag
  li x20, 0
  #base address of array of storing the integers
  la x21, int_buffer
  #initialize the ascii code of 0
  addi x22, x0, 48
  #initialize the ascii code of negative sign
  addi x23, x0, 45
  #constant 10, for multiplying the digit
  addi x24, x0, 10
  li t2, 58
  #number of integers stored in the buffer
  li x27, 0
  li x25, 0
  li x26, 1
  li t4, '\n'
  li t6, ' '
  #la a2, string_buffer

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
    la a2, string_buffer
    #insert new line
    li a0, 11
    li a1, '\n'
    ecall
 
  convert_loop:
    lbu t1, 0(a2)
    addi a2, a2, 1
    beq t1, x0, print_buffer
    beq t1, x23, negaflag
    beq t1, t4, reset_and_store
    beq t1, t6, reset_and_store
    bne t1, x23, convert_process
    blt t1, x22, convert_loop
    bge t1, t2, convert_loop
    
    convert_process:
      sub t1, t1, x22 
      mul x25, x25, x24
      add x25, x25, t1
      li x19, 1
      j convert_loop

  
  negaflag:
    addi x26, x0, -1
    j convert_loop
  
  reset_and_store:
    beq x19, x0, convert_loop
    slli x6, x27, 2
    add x6, x6, x21
    mul x25, x25, x26
    sw x25, 0(x6)
    addi x27, x27, 1
    li x25, 0
    li x26, 1
    li x19, 0
    j convert_loop

  print_buffer:
    mv x30, x0
    
  print_numbers:
    # Print message 1
    li a0, 4
    la a1, msg1
    ecall

    # Print counter of integers
    li a0, 1
    mv a1, x27
    ecall

    li a0, 11
    li a1, '\n'
    ecall
  
  printNum: 
    slli  x22, x30, 2 #offset to the base address of intData
    add   x22, x22, x21 # address of the number being printed
    lw    a1, 0(x22)
    li    a0, 1
    ecall
    addi x30, x30, 1
    li a0, 11
    li a1, ' '
    ecall
    bne x30, x27, printNum

  #close the file 
  li a0, 16
  mv a1, t3
  ecall

  #exit 
  li a0, 10
  ecall