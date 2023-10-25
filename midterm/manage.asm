; Name: Tomas Oh
; Section: CPSC 240-03
; CWID: 885566877
; Email: tomasoh@csu.fullerton.edu

array_size equ 10

extern printf       ; external C function to write to standard output
extern input_array  ; external function from the assembly module input_array.asm
extern output_array ; external function from the assembly module output_array.asm
extern sum_array    ; external function from the assembly module sum.asm  
extern rotate_left  ; external function from the assembly module rot_left.asm 
global manage_array

segment .data
    input_numbers_message     db "Please enter floating point numbers separated by ws.  After the last valid input enter one more ws followed by control+d.", 10, 0
    show_numbers_message_one  db "This is the array: ", 0
    show_numbers_message_two  db "Here is the array: ", 0
    rotate_call_message_one   db "Function rot_left was called 1 time.", 10, 0
    rotate_call_message_two   db "Function rot_left was called 2 times consecutively.", 10, 0
    rotate_call_message_three db "Function rot_left was called 3 times consecutively.", 10, 0
    concluding_message        db "Thank you for using Array Management System", 10, 0

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

    ; Print message that it will ask for numbers in the array
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
    mov         rsi, show_numbers_message_one
    call        printf

    ; Output the elements in the array using the external assembly
    ; function from module output_array.asm
    mov         rax, 0
    mov         rdi, array
    mov         rsi, r13
    call        output_array

    ; Print a message that it will rotate each of the numbers in the array to the left by one
    mov         rax, 0
    mov         rdi, string_format
    mov         rsi, rotate_call_message_one
    call        printf

    mov         rax, 0
    mov         rdi, array
    mov         rsi, r13
    call        rotate_left

    ; Output the elements in the array using the external assembly
    ; function from module output_array.asm

    ; Print a message that it will show the numbers in the array next
    mov         rax, 0
    mov         rdi, string_format
    mov         rsi, show_numbers_message_two
    call        printf
    
    mov         rax, 0
    mov         rdi, array
    mov         rsi, r13
    call        output_array

    ; Print a message that it will rotate each of the numbers in the array to the left by three
    mov         rax, 0
    mov         rdi, string_format
    mov         rsi, rotate_call_message_three
    call        printf

    ; Call rotate_left three times
    mov         rax, 0
    mov         rdi, array
    mov         rsi, r13
    call        rotate_left

    mov         rax, 0
    mov         rdi, array
    mov         rsi, r13
    call        rotate_left

    mov         rax, 0
    mov         rdi, array
    mov         rsi, r13
    call        rotate_left

    ; Output the elements in the array using the external assembly
    ; function from module output_array.asm

    ; Print a message that it will show the numbers in the array next
    mov         rax, 0
    mov         rdi, string_format
    mov         rsi, show_numbers_message_two
    call        printf

    mov         rax, 0
    mov         rdi, array
    mov         rsi, r13
    call        output_array

    ; Print a message that it will rotate each of the numbers in the array to the left by two
    mov         rax, 0
    mov         rdi, string_format
    mov         rsi, rotate_call_message_two
    call        printf

    ; Call rotate_left two times
    mov         rax, 0
    mov         rdi, array
    mov         rsi, r13
    call        rotate_left

    mov         rax, 0
    mov         rdi, array
    mov         rsi, r13
    call        rotate_left

    ; Print a message that it will show the numbers in the array next
    mov         rax, 0
    mov         rdi, string_format
    mov         rsi, show_numbers_message_two
    call        printf

    ; Output the elements in the array using the external assembly
    ; function from module output_array.asm
    mov         rax, 0
    mov         rdi, array
    mov         rsi, r13
    call        output_array

    ; Sum the numbers in the array
    mov         rax, 0
    mov         rdi, array
    mov         rsi, r13
    call        sum_array

    ; Move the result to a safe register (xmm8)
    movsd       xmm8, xmm0

    sub         rsp, 8
    movsd       qword [rsp], xmm8

    ;==== Perform State Component Restore ====
    mov         rax, 7
    mov         rdx, 0
    xrstor      [backup]
    ;==== End State Component Restore ========

    movsd       xmm8, qword [rsp]
    add         rsp, 8

    movsd       xmm0, xmm8

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

    ret