; Author name: Tomas Oh
; Author email: tomasoh@fullerton.edu

;Declarations
null equ 0
newline equ 10

extern printf
global show_numbers

segment .data

    header db "Cell#   Address (aligned)      Data decimal     Data hex (IEEE)",newline,null
    dataline db "%3ld   0x%016lx   %16.8lf   0x%016lx",newline,null

segment .text

show_numbers:

    ;Back up the general purpose registers for the sole purpose of protecting the data of the caller.
    push rbp                                          ;Backup rbp
    mov  rbp,rsp                                      ;The base pointer now points to top of stack
    push rdi                                          ;Backup rdi
    push rsi                                          ;Backup rsi
    push rdx                                          ;Backup rdx
    push rcx                                          ;Backup rcx
    push r8                                           ;Backup r8
    push r9                                           ;Backup r9
    push r10                                          ;Backup r10
    push r11                                          ;Backup r11
    push r12                                          ;Backup r12
    push r13                                          ;Backup r13
    push r14                                          ;Backup r14
    push r15                                          ;Backup r15
    push rbx                                          ;Backup rbx
    pushf                                             ;Backup rflags

    ;Registers rax, rip, and rsp are usually not backed up.

    ;Back up the incoming parameter
    mov r13, rdi  ;r13 is the array
    mov r14, rsi  ;r14 is the count of valid numbers in the array

    ;Block that displays the header
    mov rax, 0
    mov rdi, header
    call printf

    ;Block to create a loop
    xor r15,r15   ;r15 is the loop counter

begin_loop:
    cmp r15,r14
    jge done
    mov rax,1
    mov rdi,dataline       ;First parameter
    mov rsi,r15            ;Second paramter
    mov r12,r15
    shl r12,3              ;<==Fast multiplication by 8
    add r12,r13
    mov rdx,r12            ;Third parameter
    movsd xmm0,[r13+8*r15] ;Fourth parameter
    mov rcx,[r13+8*r15]    ;Fifth parameter
    call printf
    inc r15
    jmp begin_loop

done:
    ;return 0 which is the traditional signal of success
    xor rax,rax

    ;Restore all the previously pushed registers.
    popf                                    ;Restore rflags
    pop rbx                                 ;Restore rbx
    pop r15                                 ;Restore r15
    pop r14                                 ;Restore r14
    pop r13                                 ;Restore r13
    pop r12                                 ;Restore r12
    pop r11                                 ;Restore r11
    pop r10                                 ;Restore r10
    pop r9                                  ;Restore r9
    pop r8                                  ;Restore r8
    pop rcx                                 ;Restore rcx
    pop rdx                                 ;Restore rdx
    pop rsi                                 ;Restore rsi
    pop rdi                                 ;Restore rdi
    pop rbp                                 ;Restore rbp

    ret                                     ;Pop the integer stack and jump to the address equal to the popped value.