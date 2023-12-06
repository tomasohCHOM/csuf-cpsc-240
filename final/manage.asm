; Name:Tomas Oh
; Section: CPCS 240-03
; Email: tomasoh@csu.fullerton.edu
; Date: December 6, 2023

array_size equ 8

extern printf
extern input_array
extern output_array
global manage_array

segment .data
    initial_message               db "We will take care of all your array needs.", 10, 0
    input_numbers_message         db "Please input float numbers separated by ws. After the last number press ws followed by control-d.", 10, 0
    show_numbers_message          db "Here are the values in the array.", 10, 0
    finish_show_numbers_message   db "The numbers of the array have been displayed.", 10, 0
    concluding_message            db "Thank you for using Array Management System.", 10, 0

    string_format db "%s", 0
    floatform     db "%lf", 0

segment .bss
    align   64
    backup  resb 832
    array   resq array_size


segment .text

manage_array:
    push        rbp
    mov         rbp, rsp
    push        rbx
    push        rcx
    push        rdx
    push        rsi
    push        rdi
    push        r8 
    push        r9 
    push        r10
    push        r11
    push        r12
    push        r13
    push        r14
    push        r15
    pushf

    ;==== Perform State Component Backup ====
    mov         rax, 7
    mov         rdx, 0
    xsave       [backup]
    ;==== End State Component Backup ========

    mov         rax, 0
    mov         rdi, string_format
    mov         rsi, initial_message
    call        printf

    mov         rax, 0
    mov         rdi, string_format
    mov         rsi, input_numbers_message
    call        printf

    mov         rax, 0
    mov         rdi, array
    mov         rsi, array_size
    call        input_array

    mov         rax, 0
    mov         rdi, string_format
    mov         rsi, show_numbers_message
    call        printf

    mov         rax, 0
    mov         rdi, array
    mov         rsi, array_size
    call        output_array

    mov         rax, 0
    mov         rdi, string_format
    mov         rsi, finish_show_numbers_message
    call        printf

    mov         rax, 0
    mov         rdi, string_format
    mov         rsi, concluding_message
    call        printf

    ;==== Perform State Component Restore ====
    mov         rax, 7
    mov         rdx, 0
    xrstor      [backup]
    ;==== End State Component Restore ========

    mov         rax, array_size

    ;Restore the original values to the GPRs
    popf          
    pop         r15
    pop         r14
    pop         r13
    pop         r12
    pop         r11
    pop         r10
    pop         r9 
    pop         r8 
    pop         rdi
    pop         rsi
    pop         rdx
    pop         rcx
    pop         rbx
    pop         rbp

    ; Clean up
    ret
