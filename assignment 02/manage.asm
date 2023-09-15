number_of_cells equ 8

extern printf         ; external C function to write to standard output
extern input_array    ; external function from the assembly module input_array.asm
extern show_numbers   ; external function from the assembly module output_array.asm
global manage_array

segment .data
    initial_message       db "We will take care of all your array needs.", 10, 0
    input_numbers_message db "Please input float numbers separated by ws. After the last number press ws followed by control-d.", 10, 0
    show_numbers_message  db "Thank you. The numbers in the array are:", 10, 0
    sum_numbers_message   db "The sum of the numbers in the array is %lf", 10, 0
    concluding_message    db "Thank you for using Array Management System", 10, 0

    string_format db "%s", 0
    floatform     db "%lf", 0

segment .bss
    align   16
    plywood resq number_of_cells

section .text

manage_array:
    ; Backup all General Purpose Registers
    push      rbp
    mov       rbp, rsp
    push      rbx
    push      rcx
    push      rdx
    push      rsi
    push      rdi
    push      r8
    push      r9
    push      r10
    push      r11
    push      r12
    push      r13
    push      r14
    push      r15
    pushf

    ; Show the initial messasges to the user
    mov qword rax, 0
    mov       rdi, string_format
    mov       rsi, initial_message
    call      printf

    mov       rax, 0
    mov       rdi, string_format
    mov       rsi, input_numbers_message
    call      printf

    ; Prepare to take in numbers to the array by using the external
    ; assembly function from module input_array.asm
    mov       rax, 0
    mov       rdi, plywood
    mov       rsi, number_of_cells
    call      input_array
    mov       r13, rax

    ; Output the elements in the array using the external assembly
    ; function from module output_array.asm
    mov       rax, 0
    mov       rdi, plywood
    mov       rsi, r13
    call      show_numbers

    xorpd     xmm0, xmm0
    ; Restoring the original value to the General Purpose Registers
    popf
    pop       r15
    pop       r14
    pop       r13
    pop       r12
    pop       r11
    pop       r10
    pop       r9
    pop       r8
    pop       rdi
    pop       rsi
    pop       rdx
    pop       rcx
    pop       rbx
    pop       rbp

    ret