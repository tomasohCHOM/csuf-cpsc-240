; Author name: Tomas Oh
; Author email: tomasoh@csu.fullerton.edu
; Operating System: Ubuntu 22.04
; For: Assignment 2 - Array Management System
; Purpose of this file:
;   This is the sum.asm module that is in charge of summing all the elements
;   in the array and returning them as a single floting-point number. Like
;   output_array.asm, we use a loop to walk through each of our elements in the
;   array, adding its value to the main sum, until there are no more elements.
;   However, unlike output_array.asm, we are not displaying anything to the user,
;   since that is taken charge by the manage.asm module.
; Completion Date: 09/18/2023
; Updated Date: 09/24/2023

;Declarations
global sum_array

segment .data

segment .bss
    align   64
    backup  resb 832

segment .text

sum_array:
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
    ; Check if we are done with the loop or not
    cmp     r13, r15
    jge     done

    ; Add the current value to the total
    addsd   xmm8, [r14+8*r13]
    ;Increment the couter and jump to the next iteration
    inc     r13
    jmp     begin_loop

done:
    ; Push xmm8
    ; We do this step because after state component restore, xmm values are wiped
    sub     rsp, 8
    movsd  qword [rsp], xmm8

    ;==== Perform State Component Restore ====
    mov     rax, 7
    mov     rdx, 0
    xrstor  [backup]
    ;==== End State Component Restore ========

    ; Pop xmm8
    movsd   xmm8, qword [rsp]
    add     rsp, 8

    ; Move the calculated sum to xmm0
    movsd   xmm0, xmm8

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