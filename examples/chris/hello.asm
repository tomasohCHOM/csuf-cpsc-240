section .data
    message db "Happy Birthday Chris Sawyer", 10
section .text
    global _start

_start:
    mov rax, 1
    mov rdi, 1
    mov rsi, message
    mov rdx, 28
    syscall
    
    mov rax, 60
    mov rdi, 0
    syscall