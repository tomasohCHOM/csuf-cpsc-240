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

; Author name: Tomas Oh
; Author email: tomasoh@csu.fullerton.edu
; C.W.I.D.: 885566877
; Section: CPSC 240-03
; For: Assignment 3 - Sort By Pointers
; Due Date: 10/09/2023
; Completion Date: 10/06/2023
; Updated Date: 10/06/2023
; Operating System: Ubuntu 22.04
; This file
;   File name: sortpointers.asm
;   Language: X86 with Intel syntax.
;   Purpose:
;       This assembly module is responsible for sorting the elements in
;       an array based on their pointers, rather than the floating-point
;       values themselves. The sorting method used is bubble sort and the
;       steps for it are outlined in blocks of comments throughout the code.
;       Additionally, the author chooses to refer to some of the registers
;       as if they were C++ variables because the same function is done in that
;       language.

global sort_pointers

; Used for state component backup/restore
segment .bss
    align   64
    backup  resb 832

segment .text

sort_pointers:
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
    mov     rax, 7
    mov     rdx, 0
    xsave   [backup]
    ;==== End State Component Backup ========

    mov         r14, rdi    ; r14 is the array
    mov         r15, rsi    ; r15 is the number of elements in the array
    xor         r13, r13    ; r13 is the limit of the outer loop's condition
    xor         r12, r12    ; r12 is the limit of the inner loop's condition
    jmp         outer_loop

; This is the outerloop of the sort_pointers function. It looks through the
outer_loop:
    ; If r13 >= r15, exit the loops and we are done
    ; Equivalent to the loop condition i < size in sortpointers.cpp
    cmp         r13, r15
    jge         done

    ; r12 is equivalent to j = size - i - 1 in sortpointers.cpp
    mov         r12, r15
    sub         r12, 1
    sub         r12, r13

    ; r11 is initialized to 0
    xor         r11, r11
    jmp         inner_loop

inner_loop:
    ; If r11 >= r12, exit the inner loop and go to the next outer loop iteration
    ; Equivalent to the loop condition j < size - i - 1 in sortpointers.cpp
    cmp         r11, r12
    jge         increment_outer

    ; r10 contains the pointer to the first value (arr[j] in sortpointers.cpp)
    mov         r10, [r14 + r11*8]
    ; r9 contains the pointer to the value immediately after (arr[j + 1] in sortpointers.cpp)
    mov         r9, [r14 + r11*8 + 8]

    ; Load the floating-pint values from memory before comparing
    ; xmm8 = *(arr[j]) in sortpointers.cpp
    movsd       xmm8, [r10]
    ; xmm9 = *(arr[j + 1]) in sortpointers.cpp
    movsd       xmm9, [r9]

    ; Compare the values pointed to by r10 and r9. If xmm8 <= xmm9, we skip swapping
    ; Equivalent to the condition *(arr[j]) > *(arr[j + 1]) in sortpointers.cpp
    ; This case, it would be *(arr[j]) <= *(arr[j + 1]) to skip swapping
    ucomisd     xmm8, xmm9
    jbe         increment_inner

    ; Perform the swapping of pointers
    ;Set array[j] to array[j + 1]
    mov [r14 + r11*8], r9
    ;Set array[j + 1] to original value of array[j]
    mov [r14 + r11*8 + 8], r10

    ; We are done with swapping at this pointer
    ; Now we increment the inner counter and proceed to the next iteration of inner loop
    jmp         increment_inner


increment_inner:
    inc         r11
    jmp         inner_loop

; Incrementing counters
increment_outer:
    inc         r13 ; Increment the counter
    jmp         outer_loop

done:
    ;==== Perform State Component Restore ====
    mov     rax, 7
    mov     rdx, 0
    xrstor  [backup]
    ;==== End State Component Restore ========

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