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
    mov         r15, rsi    ; r15 is the upper-limit of the number of cells in the array
    xor         r13, r13    ; r13 is the outer counter
    xor         r12, r12    ; r12 is the inner counter
    jmp         outerloop

outerloop:
    cmp         r13, r15
    jge         done

    ; The following change the condition every loop
    mov         r12, r15
    sub         r12, 1
    sub         r12, r13
    xor         r11, r11

innerloop:
    cmp         r11, r12 ; Go to the next outer increment if the inner index reaches the condition
    jge         increment

    mov         rcx, r11
    inc         rcx ; RCX contains the inner counter index + 1
    mov         r10, [r14 + r11*8] ; r10 contains the pointer to the first value
    mov         r9, [r14 + rcx*8] ; r9 contains the pointer to the next value

    ; Load values from memory before comparing
    movsd       xmm8, [r10]
    movsd       xmm9, [r9]

    ; Compare the values pointed to by r10 and r9
    ucomisd     xmm8, xmm9
    jbe         skip ; Jump if xmm8 <= xmm9

    movsd [r10], xmm8
    movsd [r9], xmm9

    ; Swap values in memory if xmm8 > xmm9
    ; mov         r8, r10
    ; mov         r10, r9
    ; mov         r9, r8

skip:
    inc         r11
    jmp         innerloop

; Incrementing counters
increment:
    inc         r13 ; Increment the counter
    jmp         outerloop

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