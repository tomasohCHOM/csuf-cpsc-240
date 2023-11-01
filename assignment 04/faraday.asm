; Name: Tomas Oh

; Begin code area
extern printf       ; external C++ function to write to standard output
extern scanf        ; external C++ function to read from standard input
extern fgets
extern stdin
extern strlen
extern atof
extern isfloat

global faraday

segment .data
    ; Declare some messages to the users
    name_prompt_message         db "Please enter your name: ", 0
    title_prompt_message        db "Please enter your title or profession: ", 0
    welcome_message             db "We always welcome a %s to our electrical lab.", 10, 0
    voltage_prompt_message      db "Please enter the voltage of the electrical system at your site (volts): ", 0
    resistance_prompt_message   db "Please enter the electrical resistance in the system at your site (ohms): ", 0
    time_prompt_message         db "Please enter the time your system was operating (seconds): ", 0
    calculation_message         db "Thank you %s. We at Majestic are pleased to inform you that your system performed %lf joules of work.", 10, 10, 0
    congratulations_message     db "Congratulations %s. Come back any time and make use of our software.", 10, 0
    final_message               db "Everyone with title %s is welcome to use our programs at a reduced price.", 10, 10, 0

    invalid_message     db  "Attention %s. Invalid inputs have been encountered. Please run the program again.", 10, 0

    two_hundred_fifty_three_point_five  dq 253.5
    two_point_zero                      dq 2.0

    string_format       db "%s", 0
    eight_byte_format   db "%lf", 0

segment .bss
    align   64
    backup  resb 832
    name    resb 40
    title   resb 40
    num     resb 40

; Begin executable instructions
segment .text

faraday:
    ; Back up all the GPRs
    push        rbp
    mov         rbp, rsp
    push        rbx
    push        rcx
    push        rdx
    push        rsi
    push        rdi
    push        r8
    push        r9
    push        r10
    push        r11
    push        r12
    push        r13
    push        r14
    push        r15
    pushf

    ;==== Perform State Component Backup ====
    mov         rax, 7
    mov         rdx, 0
    xsave       [backup]
    ;==== End State Component Backup ========

    ; Ask for the user's name
    mov         rax, 0
    mov         rdi, string_format
    mov         rsi, name_prompt_message
    call        printf

    ; Receive input (representing the user's name) with fgets
    mov         rax, 0
    mov         rdi, name
    mov         rsi, 40
    mov         rdx, [stdin]
    call        fgets

    ; Strip the newline character by getting the string's length
    ; and removing the last character of the string
    mov         rax, 0
    mov         rdi, name
    call        strlen

    mov         byte [name + rax - 1], 0

    ; Ask for the user's title
    mov         rax, 0
    mov         rdi, string_format
    mov         rsi, title_prompt_message
    call        printf

    ; Receive input (representing the user's title) with fgets
    mov         rax, 0
    mov         rdi, title
    mov         rsi, 40
    mov         rdx, [stdin]
    call        fgets

    ; Strip the newline character by getting the string's length
    ; and removing the last character of the string
    mov         rax, 0
    mov         rdi, title
    call        strlen

    mov         byte [title + rax - 1], 0

    ; Welcome the user given their title
    mov         rax, 0
    mov         rdi, welcome_message
    mov         rsi, title
    call        printf

    ; Prompt for the voltage of the electrical system
    mov qword   rax, 0
    mov         rdi, string_format
    mov         rsi, voltage_prompt_message
    call        printf

    ; mov qword   rax, 0
    ; mov         rdi, eight_byte_format
    ; mov         rsi, rsp
    ; call        scanf
    ; movsd       xmm8, qword [rsp]
    mov         rax, 0
    mov         rdi, num
    mov         rsi, 40
    mov         rdx, [stdin]
    call        fgets

    ; Strip the newline character by getting the string's length
    ; and removing the last character of the string
    mov         rax, 0
    mov         rdi, title
    call        strlen

    mov         byte [title + rax - 1], 0

    ; Validate that the input is a floating-point number
    mov         rax, 0
    mov         rdi, num
    call        isfloat
    cmp         rax, 0
    je          invalid

    mov         rax, 0
    mov         rdi, num
    call        atof
    movsd       xmm8, xmm0

    ; Prompt for the electrical resistance in the system
    mov qword   rax, 0
    mov         rdi, string_format
    mov         rsi, resistance_prompt_message
    call        printf

    mov qword   rax, 0
    mov         rdi, eight_byte_format
    mov         rsi, rsp
    call        scanf
    movsd       xmm9, qword [rsp]

    ; Prompt for the time that the system has been operating for
    mov qword   rax, 0
    mov         rdi, string_format
    mov         rsi, time_prompt_message
    call        printf

    mov qword   rax, 0
    mov         rdi, eight_byte_format
    mov         rsi, rsp
    call        scanf
    movsd       xmm10, qword [rsp]

    ; xmm8 = V, xmm9 = R, xmm10 = T
    ; xmm11 = V / R = I
    movsd       xmm11, xmm8
    divsd       xmm11, xmm9

    ; xmm12 = V x I = P
    movsd       xmm12, xmm8
    mulsd       xmm12, xmm11

    ; xmm13 = P x T = W
    movsd       xmm13, xmm12
    mulsd       xmm12, xmm10

    ; Print the calculated result to the user
    mov         rax, 1
    mov         rdi, calculation_message
    mov         rsi, title
    movsd       xmm0, xmm12
    call        printf

    ; Congratulate the user before returning to the C driver
    mov         rax, 0
    mov         rdi, congratulations_message
    mov         rsi, name
    call        printf

    mov         rax, 0
    mov         rdi, final_message
    mov         rsi, title
    call        printf

    jmp         done

invalid:
    mov         rax, 0
    mov         rdi, invalid_message
    mov         rsi, title
    call        printf
    
    jmp         done

done:
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
    pop         r15
    pop         r14
    pop         r13
    pop         r12
    pop         r11
    pop         r10
    pop         r9
    pop         r8
    pop         rdi
    pop         rsi
    pop         rdx
    pop         rcx
    pop         rbx
    pop         rbp

    ret

; End of faraday.asm program