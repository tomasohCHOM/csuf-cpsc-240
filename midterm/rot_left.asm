; Name: Tomas Oh
; Section: CPSC 240-03
; CWID: 885566877
; Email: tomasoh@csu.fullerton.edu

global rotate_left

segment .bss
    align 64
    Save resb 832

segment .text
    
rotate_left:
    ; Backup registers
    push rbp
    mov rbp, rsp
    push rbx
    push rcx
    push rdx
    push rsi
    push rdi
    push r8
    push r9
    push r10
    push r11
    push r12
    push r13
    push r14
    push r15
    pushf

    ; Backup AVX, SSE, FPU registers
    mov rax, 7
    mov rdx, 0
    xsave [Save]

    ; Function parameters
    mov r14, rdi               ; r14 is the address of array a
    mov r13, rsi               ; r13 is the array length

    movsd xmm0, [r14]          ; xmm0 = a[0]

    ; Function body
    mov r15, 1                 ; r15 is the loop counter, initialize to 1

begin_loop:
    ; If loop counter >= length, exit
    cmp r15, r13
    jge end_loop

    ; Shift the current element to the left
    movsd xmm1, [r14 + r15 * 8]  ; xmm1 = arr[i]
    movsd [r14 + (r15 - 1) * 8], xmm1  ; arr[i-1] = arr[i]

    ; Increment the loop counter
    inc r15
    jmp begin_loop

end_loop:
    movsd [r14 + (r13 - 1) * 8], xmm0

    mov rax, 7
    mov rdx, 0
    xrstor [Save]

    popf
    pop r15
    pop r14
    pop r13
    pop r12
    pop r11
    pop r10
    pop r9
    pop r8
    pop rdi
    pop rsi
    pop rdx
    pop rcx
    pop rbx
    pop rbp

    ret