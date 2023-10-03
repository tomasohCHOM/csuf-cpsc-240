; Author name: Tomas Oh
; Author email: tomasoh@csu.fullerton.edu
; Operating System: Ubuntu 22.04
; For: Assignment 2 - Array Management System
; Purpose of this file:
;   This is the manage.asm module used to create an array of doubles using user input.
;   The function itself calls three other functions, namely input_array, output_array,
;   and sum_array. It also takes in a pointer to an unsigned long integer (from C driver), 
;   which is the number of user inputs present in the array (although the mac capacity is 8).
;   This assembly module will return an array of doubles, and will modify the parameter
;   coming from rdi to be the number of inputs from the user.
; Completion Date: 09/18/2023
; Updated Date: 09/24/2023

array_size equ 8

extern printf       ; external C function to write to standard output
extern input_array  ; external function from the assembly module input_array.asm
extern output_array ; external function from the assembly module output_array.asm
extern sum_array    ; external function from the assembly module sum.asm   
global manage_array

segment .data
    initial_message       db "We will take care of all your array needs.", 10, 0
    input_numbers_message db "Please input float numbers separated by ws. After the last number press ws followed by control-d.", 10, 0
    show_numbers_message  db "Thank you. The numbers in the array are:", 10, 0
    sum_numbers_message   db "The sum of the numbers in the array is %lf", 10, 0
    concluding_message    db "Thank you for using Array Management System", 10, 0

    string_format db "%s", 0
    floatform     db "%lf", 0

segment .bss
    align   64
    backup  resb 832
    array   resq array_size

section .text

manage_array:
    ; Backup all General Purpose Registers
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
    mov         rax, 7
    mov         rdx, 0
    xsave       [backup]
    ;==== End State Component Backup ========

    ; Show the initial messasges to the user
    mov qword   rax, 0
    mov         rdi, string_format
    mov         rsi, initial_message
    call        printf

    mov         rax, 0
    mov         rdi, string_format
    mov         rsi, input_numbers_message
    call        printf

    ; Prepare to take in numbers to the array by using the external
    ; assembly function from module input_array.asm
    mov         rax, 0
    mov         rdi, array
    mov         rsi, array_size
    call        input_array
    mov         r13, rax

    ; Print a message that it will show the numbers in the array next
    mov         rax, 0
    mov         rdi, string_format
    mov         rsi, show_numbers_message
    call        printf

    ; Output the elements in the array using the external assembly
    ; function from module output_array.asm
    mov         rax, 0
    mov         rdi, array
    mov         rsi, r13
    call        output_array

    ; Print a message that it will sum each of the numbers in the array
    mov         rax, 0
    mov         rdi, array
    mov         rsi, r13
    call        sum_array
    ; Move the result to a safe register (xmm15)
    movsd       xmm15, xmm0

    ; Print the result to the user
    mov         rax, 1
    mov         rdi, sum_numbers_message
    call        printf

    ;==== Perform State Component Restore ====
    mov         rax, 7
    mov         rdx, 0
    xrstor      [backup]
    ;==== End State Component Restore ========

    ; Return a double which is the sum of the elements in the array
    ; OR for the challenge part, prepare to return the array itself 
    movsd       xmm0, xmm15
    mov         rax, r13    ; We need to move the value of r13 to rax because r13 will be restored

    ; Restoring the original value to the General Purpose Registers
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

    ; Mutates the value of the parameter to the number of user inputs
    mov     qword [rdi], rax
    mov     rax, array    ; Return the array to the C module

    ret