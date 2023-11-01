; Name: Tomas Oh

; Begin code area
extern printf       ; external C++ function to write to standard output
extern scanf        ; external C++ function to read from standard input
extern fgets
extern strlen
extern atof
extern isfloat

global faraday

segment .data
    ; Declare some messages to the users
    name_prompt_message         db "Please enter your name: ", 0
    title_prompt_message        db "Please enter your title or profession: ", 0
    welcome_message             db "We always welcome a card player to our electrical lab.", 10, 0
    voltage_prompt_message      db "Please enter the voltage of the electrical system at your site (volts): ", 0
    resistance_prompt_message   db "Please enter the electrical resistance in the system at your site (ohms): ", 0
    time_prompt_message         db "Please enter the time your system was operating (seconds): ", 0
    calculation_message         db "Thank you card player. We at Majestic are pleased to inform you that your system performed %lf joules of work.", 10, 10, 0
    congratulations_message     db "Congratulations Diego de Las Vegas. Come back any time and make use of our software.", 10, 0
    final_message               db "Everyone with title card player is welcome to use our programs at a reduced price.", 10, 10, 0
    
    negative_message    db  "You inputted a negative or 0 as a number.", 10, 0
    greater_num_message db  "You inputted a number greater than or equal to the number of miles.", 10, 0
    invalid_message     db  "The input is invalid and was rejected by the program. The program will soon terminate. Please run it again.", 10, 0

    two_hundred_fifty_three_point_five  dq 253.5
    two_point_zero                      dq 2.0

    string_format       db "%s", 0
    eight_byte_format   db "%lf", 0

segment .bss
    align   64
    backup  resb 832
    name    resb 32
    title   resb 40

; Begin executable instructions
segment .text

faraday:
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

    ;==== Perform State Component Backup ====
    mov         rax, 7
    mov         rdx, 0
    xsave       [backup]
    ;==== End State Component Backup ========

    ; Prompt for the speed of the intial segment of the trip
    mov qword   rax, 0
    mov         rdi, string_format
    mov         rsi, voltage_prompt_message
    call        printf

    ; Obtain the initial speed from standard input
    mov qword   rax, 0
    mov         rdi, eight_byte_format
    mov         rsi, rsp
    call        scanf
    movsd       xmm8, qword [rsp]

    ; Prompt for the number of miles that the speed will be maintained
    mov qword   rax, 0
    mov         rdi, string_format
    mov         rsi, resistance_prompt_message
    call        printf

    ; Obtain the number of miles that this speed will be maintained
    mov qword   rax, 0
    mov         rdi, eight_byte_format
    mov         rsi, rsp
    call        scanf
    movsd       xmm9, qword [rsp]

    ; Prompt for the speed of the final segment of the trip
    mov qword   rax, 0
    mov         rdi, string_format
    mov         rsi, time_prompt_message
    call        printf

    ; Obtain the final speed from standard input
    mov qword   rax, 0
    mov         rdi, eight_byte_format
    mov         rsi, rsp
    call        scanf
    movsd       xmm10, qword [rsp]

    movsd       xmm11, xmm8
    divsd       xmm11, xmm9
    movsd       xmm12, xmm8
    mulsd       xmm12, xmm11
    movsd       xmm13, xmm12
    mulsd       xmm12, xmm10

    mov         rax, 1
    mov         rdi, calculation_message
    movsd       xmm0, xmm12
    call        printf

    mov         rax, 0
    mov         rdi, congratulations_message
    call        printf

    mov         rax, 0
    mov         rdi, final_message
    call        printf

    jmp         setreturnvalue

negative:
    mov         rax, 0
    mov         rdi, negative_message
    call        printf

    mov         rax, 0
    mov         rdi, invalid_message
    call        printf
    jmp         setreturnvalue

greater_than_or_equal_to_miles:
    mov         rax, 0
    mov         rdi, greater_num_message
    call        printf

    mov         rax, 0
    mov         rdi, invalid_message
    call        printf
    jmp         setreturnvalue

setreturnvalue:
    sub         rsp, 8
    movsd       qword [rsp], xmm12

    ;==== Perform State Component Restore ====
    mov         rax, 7
    mov         rdx, 0
    xrstor      [backup]
    ;==== End State Component Restore ========

    movsd       xmm12, qword [rsp]
    add         rsp, 8

    movsd       xmm0, xmm12
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

; End of faraday.asm program