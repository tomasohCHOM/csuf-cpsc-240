global input_array

segment .data:
    floatform db "%lf", 0

segment .text:

input_array:
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

    mov     r14, rdi    ; r14 is the array
    mov     r15, rsi    ; r15 is the upper-limit of the number of cells in the array
    mov     r13, 0      ; r13 to count input

    push qword   0
    mov     rax, 0
    mov     rdi, floatform
    mov     rdi, rsp
    call    scanf       ; either a float number or ctrl-d


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
