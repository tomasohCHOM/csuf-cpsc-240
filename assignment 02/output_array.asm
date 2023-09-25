; Author name: Tomas Oh
; Author email: tomasoh@csu.fullerton.edu
; Operating System: Ubuntu 22.04
; For: Assignment 2 - Array Management System
; Purpose of this file:
;   This is the output_array.asm module that displays the array contents to standard
;   output. It will loop through the elements in the array one by one and
;   print them in a new line, using the printf function from the C library.
;   This procedure is achieved through looping the elements with the condition
;   that it will stop upon the nth time, where n is the number of user inputs 
;   coming from input_array.asm, which precede this function.
; Completion Date: 09/18/2023
; Updated Date: 09/24/2023

;Declarations
extern printf
global output_array

segment .data
    number_in_array db "%1.10lf", 10, 0

segment .bss
    align   64
    backup  resb 832

segment .text

output_array:
    ; Back up all the GPRs
    push    rbp
    mov     rbp, rsp
    push    rbx
    push    rcx
    push    rdx
    push    rsi
    push    rdi
    push    r8
    push    r9
    push    r10
    push    r11
    push    r12
    push    r13
    push    r14
    push    r15
    pushf

    ;==== Perform State Component Backup ====
    mov     rax, 7
    mov     rdx, 0
    xsave   [backup]
    ;==== End State Component Backup ========

    ;Back up the incoming parameter
    mov     r14, rdi  ;r14 is the array
    mov     r15, rsi  ;r15 is the count of valid numbers in the array

    ;Block to create a loop
    xor     r13, r13   ;r13 is the loop counter

begin_loop:
    cmp     r13, r15
    jge     done

    mov     rax, 1
    mov     rdi, number_in_array
    mov     rsi, r13            ;Second paramter
    mov     r12, r13
    shl     r12, 3              ;<==Fast multiplication by 8
    add     r12, r14
    mov     rdx, r12            ;Third parameter
    movsd   xmm0, [r14+8*r13]   ;Fourth parameter
    mov     rcx, [r14+8*r13]    ;Fifth parameter
    call    printf
    inc     r13
    jmp     begin_loop

done:
    ;==== Perform State Component Restore ====
    mov     rax, 7
    mov     rdx, 0
    xrstor  [backup]
    ;==== End State Component Restore ========


    ;return 0 which is the traditional signal of success
    xor     rax, rax

    ; Restoring the original value to the GPRs
    popf
    pop     r15
    pop     r14
    pop     r13
    pop     r12
    pop     r11
    pop     r10
    pop     r9
    pop     r8
    pop     rdi
    pop     rsi
    pop     rdx
    pop     rcx
    pop     rbx
    pop     rbp

    ret