; Begin code area
extern printf       ; external C++ function to write to standard output
extern scanf        ; external C++ function to read from standard input
global lasvegas

segment .data
    ; Declare some messages to the users
    initialspeedpromptmessage db "Please enter the speed for the intial segment of the trip (mph): ", 0
    milespromptmessage db "For how many miles will you maintain this average speed? ", 0
    finalspeedpromptmessage db "What will be your speed during the final segment of the trip (mph)? ", 0
    goodbye db "The main module received this number "

    two_hundred_fifty_three_point_five dq 253.5
    two_point_zero dq 2.0

    stringformat db "%s", 0
    eight_byte_format db "%lf", 0


; Begin executable instructions
segment .text

lasvegas:
    push       rbp
    mov        rbp, rsp
    push       rbx
    push       rcx
    push       rdx
    push       rsi
    push       rdi
    push       r8
    push       r9
    push       r10
    push       r11
    push       r12
    push       r13
    push       r14
    push       r15
    pushf

startapplication:
    ; Show initial message
    push qword 0
    mov qword rax, 0
    mov rdi, %stringformat
    mov rsi, initialspeedpromptmessage
    call printf
    pop rax

    push qword 0
    mov qword rax, 0
    mov rdi, %eight_byte_format
    mov rsi, rsp
    call scanf
