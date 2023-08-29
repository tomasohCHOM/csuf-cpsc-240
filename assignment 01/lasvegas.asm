; Name: Tomas Oh
; Completion Date: -/-/-

; Begin code area
extern printf       ; external C++ function to write to standard output
extern scanf        ; external C++ function to read from standard input
global lasvegas

segment .data
    ; Declare some messages to the users
    initial_speed_prompt_message    db  "Please enter the speed for the intial segment of the trip (mph): ", 0
    miles_prompt_message            db  "For how many miles will you maintain this average speed? ", 0
    final_speed_prompt_message      db  "What will be your speed during the final segment of the trip (mph)? ", 0
    average_speed_message           db  "Your average speed will be %1.18lf", 0
    total_time_message              db  "the total travel time will be %1.18lf", 0

    two_hundred_fifty_three_point_five  dq 253.5
    two_point_zero                      dq 2.0

    string_format       db "%s", 0
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

    ; Prompt for the speed of the intial segment of the trip
    mov qword   rax, 0
    mov         rdi, string_format
    mov         rsi, initial_speed_prompt_message
    call        printf
    pop rax

    ; Obtain the initial speed from standard input
    push qword  0
    mov qword   rax, 0
    mov         rdi, eight_byte_format
    mov         rsi, rsp
    call        scanf
    movsd       xmm8, [rsp]
    pop         rax

    ; Prompt for the number of miles that the speed will be maintained
    push qword  0
    mov qword   rax, 0
    mov         rdi, string_format
    mov         rsi, miles_prompt_message
    call        printf
    pop rax

    ; Obtain the number of miles that this speed will be maintained
    push qword  0
    mov qword   rax, 0
    mov         rdi, eight_byte_format
    mov         rsi, rsp
    call        scanf
    movsd       xmm9, [rsp]
    pop         rax

    ; Prompt for the speed of the final segment of the trip
    push qword  0
    mov qword   rax, 0
    mov         rdi, string_format
    mov         rsi, final_speed_prompt_message
    call        printf
    pop rax

    ; Obtain the final speed from standard input
    push qword  0
    mov qword   rax, 0
    mov         rdi, eight_byte_format
    mov         rsi, rsp
    call        scanf
    movsd       xmm10, [rsp]
    pop         rax

    ; We have x initial speed and it is maintained for the first y miles
    ; The number of hours passed is equal to y / x
    movsd       xmm11, xmm8
    divsd       xmm11, xmm9 ; xmm11 = y / x in hours

    movsd       xmm12, qword [two_hundred_fifty_three_point_five]
    subsd       xmm12, xmm9 ; xmm12 = distance - miles (2nd input)

    movsd       xmm13, xmm12
    divsd       xmm13, xmm10 ; xmm13 = remaining distance / final speed in hours

    movsd       xmm14, xmm11 ; initial time
    addsd       xmm14, xmm13 ; total time

    movsd       xmm15, xmm12
    divsd       xmm15, xmm4  ; average speed in the entire trip

    mov         rax, 1
    mov         rdi, string_format
    mov         rsi, average_speed_message
    movsd       xmm0, xmm11
    call        printf
    
    ; movsd       xmm4, qword two_hundred_fifty_three_point_five

    ; Set return value now
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
