; Name: Tomas Oh
; Completion Date: -/-/-

; Begin code area
extern printf       ; external C++ function to write to standard output
extern scanf        ; external C++ function to read from standard input
global lasvegas

segment .data
    ; Declare some messages to the users
    initialspeedpromptmessage   db  "Please enter the speed for the intial segment of the trip (mph): ", 0
    milespromptmessage          db  "For how many miles will you maintain this average speed? ", 0
    finalspeedpromptmessage     db  "What will be your speed during the final segment of the trip (mph)? ", 0
    averagespeedmessage         db  "Your average speed will be %1.18lf", 0
    totaltimemessage            db  "the total travel time will be %1.18lf", 0

    two_hundred_fifty_three_point_five  dq 253.5
    two_point_zero                      dq 2.0

    stringformat        db "%s", 0
    eight_byte_format   db "%lf", 0


; Begin executable instructions
segment .text

lasvegas:
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

    jmp     startapplication

startapplication:
    ; Prompt for the speed of the intial segment of the trip
    push qword  0
    mov qword   rax, 0
    mov         rdi, stringformat
    mov         rsi, initialspeedpromptmessage
    call        printf
    pop rax

    ; Obtain the initial speed from standard input
    push qword  0
    mov qword   rax, 0
    mov         rdi, eight_byte_format
    mov         rsi, rsp
    call        scanf
    movsd       xmm0, [rsp]
    pop         rax

    ; Prompt for the number of miles that the speed will be maintained
    push qword  0
    mov qword   rax, 0
    mov         rdi, stringformat
    mov         rsi, milespromptmessage
    call        printf
    pop rax

    ; Obtain the number of miles that this speed will be maintained
    push qword  0
    mov qword   rax, 0
    mov         rdi, eight_byte_format
    mov         rsi, rsp
    call        scanf
    movsd       xmm1, [rsp]
    pop         rax

    ; Prompt for the speed of the final segment of the trip
    push qword  0
    mov qword   rax, 0
    mov         rdi, stringformat
    mov         rsi, finalspeedpromptmessage
    call        printf
    pop rax

    ; Obtain the final speed from standard input
    push qword  0
    mov qword   rax, 0
    mov         rdi, eight_byte_format
    mov         rsi, rsp
    call        scanf
    movsd       xmm2, [rsp]
    pop         rax

setreturnvalue:
    push        r14
    movsd       xmm0, [rsp]
    pop         r14

    ; Restoring the original value to the GPRs
    popf
    pop        r15
    pop        r14
    pop        r13
    pop        r12
    pop        r11
    pop        r10
    pop        r9
    pop        r8
    pop        rdi
    pop        rsi
    pop        rdx
    pop        rcx
    pop        rbx
    pop        rbp

    ret

; End of lasvegas.asm program
