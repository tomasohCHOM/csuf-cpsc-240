;*****************************************************************************************************
; Program name: "Sort by Pointers." This program demonstrates the input of
; array values as pointers and the sorting of its elements (pointers) based
; off its values (floating-point numbers). Copyright (C) 2023 Tomas Oh.
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
;*****************************************************************************************************

;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0**
;
;Author information
;  Author name: Tomas Oh
;  Author email: tomasoh@csu.fullerton.edu
;  Author CWID: 885566877
;  Author NASM: NASM version 2.15.05
;  Author Operating System: Ubuntu 22.04
;
;Program information
;  Program name: Sort by Pointers
;  Programming languages: Two modules in C++, one module in C and three modules in X86
;  Date program due: Oct-9-2023 (Baseline) Oct-16-2023 (Challenge)
;  Date program began: Oct-1-2023
;  Date of last update: Oct-9-2023
;  Date comments upgraded: Oct-9-2023
;  Date open source license added: Oct-5-2023
;  Files in this program: 
;   main.cpp director.asm inputarray.asm outputarray.c sortpointers.asm sortpointers.cpp
;  Status: Finished.
;
;Purpose:
;  This program demonstrates creating a pointer array in which a user can input up to 10
;  numbers and the program will create an array of pointes that will point to those values.
;  The program will print those values into standard output and following that, it will start
;  sorting the elements in the array through the pointers rather than its values. Finally, it
;  will return the array to the C drier before finishing the program's execution.
;
;This file
;  File name: inputarray.asm
;  Language: X86 with Intel syntax.
;  Max page width: 132 columns
;  Assemble: nasm -f elf64 -l inputarray.lis -o inputarray.o inputarray.asm
;  Purpose:
;       This assembly module is responsible for managing user input and
;       filling the array with pointers to those values, rather than filling
;       the array with those values themselves (made possible by using malloc
;       and scanf from the C library)

;===== Begin code area ===============================================================================

extern scanf
extern malloc
global input_array

segment .data
    floatform db "%lf", 0

; Used for state component backup/restore
segment .bss
    align   64
    backup  resb 832

segment .text

input_array:
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

    mov         r14, rdi    ; r14 is the array
    mov         r15, rsi    ; r15 is the upper-limit of the number of cells in the array
    xor         r13, r13    ; r13 to count input
    jmp         input_number

; A loop that will keep asking for more floating-point numbers until
; the user presses ctrl-d
input_number:
    ; If the current index (r13) is greater than or equal to 
    ; the upper-limit (r15), conclude the loop.
    cmp         r13, r15
    jge         input_finished

    ; Create storage for one new number
    mov         rax, 0
    mov         rdi, 8
    call        malloc
    mov         r12, rax ; r12 = pointer to qword

    ; Read a floating point number from user
    mov         rax, 0
    mov         rdi, floatform
    mov         rsi, r12
    call        scanf       ; either a float number or ctrl-d

    ; Checks if the user has inputted ctrl-d and finished the job
    cdqe
    cmp         rax, -1
    je          input_finished

    ; r14 is the address of the array. r13 is like the "index"
    ; of the array. By multiplying r13 * 8, we move 8 bytes to the
    ; next iteration to input more numbers.
    mov         [r14 + r13*8], r12
    inc         r13
    jmp         input_number

input_finished:
    ;==== Perform State Component Restore ====
    mov     rax, 7
    mov     rdx, 0
    xrstor  [backup]
    ;==== End State Component Restore ========

    ; r13 holds the count of numbers in the array.
    ; Move it to rax as we are required to return that number.
    mov     rax, r13

    ; Restoring the original value to the GPRs
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

    ret
