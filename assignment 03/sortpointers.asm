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
; Due Date: 10/09/2023
; Completion Date: -/-/2023
; Updated Date: -/-/2023
; Operating System: Ubuntu 22.04
; For: Assignment 3 - Sort By Pointers
; Purpose of this file:
;    This is the C driver that contains the start code and which calls the
;    assembly function director from director.asm.

global sort_pointers

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
    xor         r13, r13    ; r13 is the outer counter
    xor         r12, r12    ; r12 is the inner counter
    jmp         outerloop

outerloop:
    

done:
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