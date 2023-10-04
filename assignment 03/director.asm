; Program name: "Sort by Pointers." This program demonstrates the input of
; array values as pointers and the sorting of its elements (pointers) based
; off its values. Copyright (C) 2023 Tomas Oh
;
; "Sort by Pointers" is free software: you can redistribute it and/or modify
; it under the terms of the GNU General Public License as published by
; the Free Software Foundation, either version 3 of the License, or
; (at your option) any later version.
; 
; "Sort by Pointers" is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
; GNU General Public License for more details.
; 
; You should have received a copy of the GNU General Public License
; along with this program.  If not, see <https://www.gnu.org/licenses/>.

; Author name: Tomas Oh
; Author email: tomasoh@csu.fullerton.edu
; C.W.I.D.: 885566877
; Due Date: 10/09/2023
; Completion Date: -/-/2023
; Updated Date: -/-/2023
; Operating System: Ubuntu 22.04
; For: Assignment 3 - Sort By Pointers
; Purpose of this file:
;    This is the C driver that contains the start code and which calls the
;    assembly function director from director.asm.

array_size equ 8

extern printf       ; external C function to write to standard output
extern input_array  ; external function from the assembly module input_array.asm
extern output_array ; external function from the assembly module output_array.asm
extern sum_array    ; external function from the assembly module sum.asm   
global manage_array

segment .data
    initial_message             db "This program will sort all of your doubles.", 10, 0
    input_numbers_message       db "Please enter floating point numbers separated by white space. After the last numeric input enter at least one more white space and press cntl+d.", 10, 0
    show_numbers_message        db "Thank you. You entered these numbers:", 10, 0
    end_show_numbers_message    db "End of output of array.", 10, 0
    start_sort_message          db "The array is now being sorted without moving any numbers.", 10, 0
    end_sort_message            db "The data in the array are now ordered as follows:", 10, 0
    concluding_message          db "The array will be sent back to the caller function.", 10, 0

    string_format db "%s", 0
    floatform     db "%lf", 0

segment .bss
    align   64
    backup  resb 832
    array   resq array_size

section .text

manage_array:
    ; Backup all General Purpose Registers
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

    ; Show the initial messasges to the user
    mov qword   rax, 0
    mov         rdi, string_format
    mov         rsi, initial_message
    call        printf

    mov         rax, 0
    mov         rdi, string_format
    mov         rsi, input_numbers_message
    call        printf

    ; Prepare to take in numbers to the array by using the external
    ; assembly function from module input_array.asm
    mov         rax, 0
    mov         rdi, array
    mov         rsi, array_size
    call        input_array
    mov         r13, rax

    ; Print a message that it will show the numbers in the array next
    mov         rax, 0
    mov         rdi, string_format
    mov         rsi, show_numbers_message
    call        printf

    ; Output the elements in the array using the external assembly
    ; function from module output_array.asm
    mov         rax, 0
    mov         rdi, array
    mov         rsi, r13
    call        output_array

    ; Print a message that it will sum each of the numbers in the array
    mov         rax, 0
    mov         rdi, array
    mov         rsi, r13
    call        sum_array
    ; Move the result to a safe register (xmm15)
    movsd       xmm15, xmm0

    ; Print the result to the user
    mov         rax, 1
    mov         rdi, sum_numbers_message
    call        printf

    ;==== Perform State Component Restore ====
    mov         rax, 7
    mov         rdx, 0
    xrstor      [backup]
    ;==== End State Component Restore ========

    ; Return a double which is the sum of the elements in the array
    ; OR for the challenge part, prepare to return the array itself 
    movsd       xmm0, xmm15
    mov         rax, r13    ; We need to move the value of r13 to rax because r13 will be restored

    ; Restoring the original value to the General Purpose Registers
    popf
    pop     r15
    pop     r14
    pop     r13
    pop     r12
    pop     r11
    pop     r10
    pop     r9
    pop     r8
    pop     rdi
    pop     rsi
    pop     rdx
    pop     rcx
    pop     rbx
    pop     rbp

    ; Mutates the value of the parameter to the number of user inputs
    mov     qword [rdi], rax
    mov     rax, array    ; Return the array to the C module

    ret