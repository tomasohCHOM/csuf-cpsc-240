; Author name: Tomas Oh
; Author email: tomasoh@fullerton.edu

;Declarations
extern printf
global output_array

segment .data
    number_in_array db "%1.10lf", 10, 0

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

    ;Registers rax, rip, and rsp are usually not backed up.

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