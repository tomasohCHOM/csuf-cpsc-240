section .data
    text1 db "Input your favorite food: "
    text2 db "Preparing "
    text3 db " right now."

section .bss
    food resb 16

section .text
    global _start
_start:
    call _printText1
    call _getFood
    call _printText2
    call _printFood
    call _printText3

    mov rax, 60
    mov rdi, 0
    syscall

_getFood:
    mov rax, 0
    mov rdi, 0
    mov rsi, food
    mov rdx, 16
    syscall
    ret

_printText1:
    mov rax, 1
    mov rdi, 1
    mov rsi, text1
    mov rdx, 26
    syscall
    ret

_printText2:
    mov rax, 1
    mov rdi, 1
    mov rsi, text2
    mov rdx, 10
    syscall
    ret

_printText3:
    mov rax, 1
    mov rdi, 1
    mov rsi, text3
    mov rdx, 11
    syscall
    ret

_printFood:
    mov rax, 1
    mov rdi, 1
    mov rsi, food
    mov rdx, 16
    syscall
    ret