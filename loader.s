.set MAGIC, 0x1badb002
.set FLAGS, (1<<0 || 1<<1)
.set CHECKSUM , -(MAGIC+FLAGS)

.section .multiboot
    .long MAGIC
    .long FLAGS
    .long CHECKSUM


.section .text
.extern kernelMain
.global loader


// seting stack pointer initially
// for this we have to limit our stack size to some size so that we may not overwrite something 
// [][][][]..... [stack begin][][][]....[stack pointer]  we define some positions for our stack end and top pointer
loader: 
    mov $kernel_stack , %esp
    push %eax 
    push %ebx
    call kernelMain

// another infinite loop to make sure we dont stop after startting although kernelMain already has an infinite loop

_stop:
     cli 
     hlt 
     jmp _stop 


// 2 Mb stack size
.section .bss
.space 2*1024*1024  
kernel_stack: