; Name:Tomas Oh
; Section: CPCS 240-03
; Email: tomasoh@csu.fullerton.edu
; Date: December 6, 2023

;Declarations
extern printf
extern scanf
global output_array

segment .data
    delay_input_message   db "What is the delay time that you prefer (seconds)? ", 0
    cpu_frequency_message db "What is the maximum frequency of your cpu (GHz)? ", 0
    output_format         db "0x%016lx = %.7E", 10, 0

    num db "The number is %lf", 10, 0

    string_format         db "%s", 0
    floatform             db "%lf", 0

segment .bss
    align 64
    storedata     resb 832
    input_time    resq 1
    cpu_frequency resq 1

segment .text

output_array:
     ; Back up components
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

    ; Save all the floating-point numbers
    mov         rax, 7
    mov         rdx, 0
    xsave       [storedata]

    xor         r13, r13     ; r13 keeps track of the index of the loop    
    mov         r14, rdi     ; rdi contains the array
    mov         r15, rsi     ; rsi contains the count of the array

    mov         rax, 0
    mov         rdi, string_format
    mov         rsi, delay_input_message
    call        printf

    mov         rax, 0
    mov         rsi, input_time
    mov         rdi, floatform
    call        scanf
    movsd       xmm8, qword [input_time]

    mov         rax, 0
    mov         rdi, string_format
    mov         rsi, cpu_frequency_message
    call        printf

    mov         rax, 0
    mov         rsi, cpu_frequency
    mov         rdi, floatform
    call        scanf
    movsd       xmm9, qword [cpu_frequency]

    mov         rax, 1
    mov         rdi, num
    movsd       xmm0, xmm9
    call        printf

    ; Get the clock
    xor         rax, rax
    xor         rdx, rdx
    cpuid
    rdtsc
    shl         rdx, 32
    or          rax, rdx
    mov         r12, rax

output_loop:
    ; If the index reach the count, end the loop
    cmp         r13, r15
    jge         output_finished
    
    ; Print the number inside the array in hex and scientific format
    mov         rax, 1
    mov         rdi, output_format  
    mov         rsi, [r14 + r13  * 8]
    movsd       xmm0, [r14 + r13 * 8]
    call        printf   

    ; Inrease the index and repeat the loop
    inc         r13
    jmp         output_loop


delay:
    movsd       xmm10, xmm8
    mulsd       xmm10, xmm9

output_finished:
    ; Restore all the floating-point numbers
    mov         rax, 7
    mov         rdx, 0
    xrstor      [storedata]

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