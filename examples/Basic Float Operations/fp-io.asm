;****************************************************************************************************************************
;Program name: "Basic Float Operations".  This program demonstrates the input and output of a float number and demonstrates *
;some basic math operations using float numbers.  Copyright (C) 2020 Floyd Holliday.                                        *
;                                                                                                                           *
;This file is part of the software program "Basic Float Operations".                                                        *
;Basic Float Operations is free software: you can redistribute it and/or modify it under the terms of the GNU General Public*
;License version 3 as published by the Free Software Foundation.                                                            *
;Basic Float Operations is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the       *
;implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more      *
;details.  A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                  *
;****************************************************************************************************************************

;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;
;Author information
;  Author name: Floyd Holliday
;  Author email: holliday@fullerton.edu
;
;Program information
;  Program name: Basic Float Operations
;  Programming languages: One modules in C++ and one module in X86
;  Date program began: 2014-Aug-25
;  Date of last update: 2014-Sep-29
;  Date comments upgraded: 2020-July-04
;  Date open source license added: 2020-Sep-20
;  Files in this program: fp-io-driver.cpp, fp-io.asm 
;  Status: Finished.
;  References consulted: Seyfarth, Chapter 11
;  Future upgrade possible: software to validate inputs and reject non-float inputs
;
;Purpose
;  This program will demonstrate how to input a single float number, multiply that inputted number by a floating point
;  constant and then output the results.
;  To students enrolled in 240 class: this program includes a secondary purpose, which is to demonstrate how to do a 
;     state component back up using instructions xsave and xrstor.  For the most part that is superflous material. You may
;     safely disregard the two sections on "state component backup".  By the way, you still have to save all the GPRs 
;     and restore them the long way.
;
;This file
;  File name: fp-io.asm
;  Language: X86 with Intel syntax.
;  Max page width: 132 columns
;  Assemble: nasm -f elf64 -l fp-io.lis -o fp-io.o fp-io.asm


;===== Begin code area ========================================================================================================

extern printf                                               ;External C++ function for writing to standard output device

extern scanf                                                ;External C++ function for reading from the standard input device

global floating_point_io                                    ;This makes floating_point_io callable by functions outside of this file.

three_point_zero equ 0x4008000000000000                     ;Use the hex expression for 64-bit floating point 3.0

segment .data                                               ;Place initialized data here

;===== Declare some messages ==================================================================================================

initialmessage db "This X86 program will demonstrate the input and output of 8-byte floating point numbers.", 10, 0

promptmessage db "Enter a floating point number in base 10: ", 0

outputmessage db "The value of %1.18lf divided by %1.18lf is %1.18lf", 10, 0

xsavenotsupported.notsupportedmessage db "The xsave instruction and the xrstor instruction are not supported in this microprocessor.", 10
                                      db "However, processing will continue without backing up state component data", 10, 0

goodbye db "I hope you like working with 8-byte floating points numbers.",10
        db "8-byte numbers have the highest precision available in an 8-byte (64-bit) microprocessor.",10,0

stringformat db "%s", 0                                     ;general string format

xsavenotsupported.stringformat db "%s", 0

eight_byte_format db "%lf", 0                               ;general 8-byte float format

segment .bss                                                ;Place un-initialized data here.

align 64                                                    ;Insure that the inext data declaration starts on a 64-byte boundar.
backuparea resb 832                                         ;Create an array for backup storage having 832 bytes.

;===== Begin executable instructions here =====================================================================================

segment .text                                               ;Place executable instructions in this segment.

floating_point_io:                                          ;Entry point.  Execution begins here.

;=========== Back up all the GPRs whether used in this program or not =========================================================

push       rbp                                              ;Save a copy of the stack base pointer
mov        rbp, rsp                                         ;We do this in order to be 100% compatible with C and C++.
push       rbx                                              ;Back up rbx
push       rcx                                              ;Back up rcx
push       rdx                                              ;Back up rdx
push       rsi                                              ;Back up rsi
push       rdi                                              ;Back up rdi
push       r8                                               ;Back up r8
push       r9                                               ;Back up r9
push       r10                                              ;Back up r10
push       r11                                              ;Back up r11
push       r12                                              ;Back up r12
push       r13                                              ;Back up r13
push       r14                                              ;Back up r14
push       r15                                              ;Back up r15
pushf                                                       ;Back up rflags


;==============================================================================================================================
;===== Begin State Component Backup ===========================================================================================
;==============================================================================================================================

;=========== Before proceeding verify that this computer supports xsave and xrstor ============================================
;Bit #26 of rcx, written rcx[26], must be 1; otherwise xsave and xrstor are not supported by this computer.
;Preconditions: rax holds 1.
mov        rax, 1

;Execute the cpuid instruction
cpuid

;Postconditions: If rcx[26]==1 then xsave is supported.  If rcx[26]==0 then xsave is not supported.

;=========== Extract bit #26 and test it ======================================================================================

and        rcx, 0x0000000004000000                          ;The mask 0x0000000004000000 has a 1 in position #26.  Now rcx is either all zeros or
                                                            ;has a single 1 in position #26 and zeros everywhere else.
cmp        rcx, 0                                           ;Is (rcx == 0)?
je         xsavenotsupported                                ;Skip the section that backs up state component data.

;========== Call the function to obtain the bitmap of state components ========================================================

;Preconditions
mov        rax, 0x000000000000000d                          ;Place 13 in rax.  This number is provided in the Intel manual
mov        rcx, 0                                           ;0 is parameter for subfunction 0

;Call the function
cpuid                                                       ;cpuid is an essential function that returns information about the cpu

;Postconditions (There are 2 of these):

;1.  edx:eax is a bit map of state components managed by xsave.  At the time this program was written (2014 June) there were exactly 3 state components.  Therefore, bits
;    numbered 2, 1, and 0 are important for current cpu technology.
;2.  ecx holds the number of bytes required to store all the data of enabled state components. [Post condition 2 is not used in this program.]
;This program assumes that under current technology (year 2014) there are at most three state components having a maximum combined data storage requirement of 832 bytes.
;Therefore, the value in ecx will be less than or equal to 832.

;Precaution: As an insurance against a future time when there will be more than 3 state components in a processor of the X86 family the state component bitmap is masked to
;allow only 3 state components maximum.

mov        r15, 7                                           ;7 equals three 1 bits.
and        rax, r15                                         ;Bits 63-3 become zeros.
mov        r15, 0                                           ;0 equals 64 binary zeros.
and        rdx, r15                                         ;Zero out rdx.

;========== Save all the data of all three components except GPRs =============================================================

;The instruction xsave will save those state components with on bits in the bitmap.  At this point edx:eax continues to hold the state component bitmap.

;Precondition: edx:eax holds the state component bit map.  This condition has been met by the two pops preceding this statement.
xsave      [backuparea]                                     ;All the data of state components managed by xsave have been written to backuparea.

push qword -1                                               ;Set a flag (-1 = true) to indicate that state component data were backed up.
jmp        startapplication

;========== Show message xsave is not supported on this platform ==============================================================
xsavenotsupported:

mov        rax, 0
mov        rdi, .stringformat
mov        rsi, .notsupportedmessage                        ;"The xsave instruction is not suported in this microprocessor.
call       printf

push qword 0                                                ;Set a flag (0 = false) to indicate that state component data were not backed up.

;==============================================================================================================================
;===== End of State Component Backup ==========================================================================================
;==============================================================================================================================


;==============================================================================================================================
startapplication: ;===== Begin the application here: demonstrate floating point i/o ===========================================
;==============================================================================================================================

;Show the initial message
push qword 0                                                ;Get onto the 16-byte boundary
mov qword  rax, 0                                           ;No data from SSE will be printed
mov        rdi, stringformat                                ;"%s"
mov        rsi, initialmessage                              ;"This X86 program will demonstrate the input and output of 8-byte ... "
call       printf                                           ;Call a library function to make the output


;Prompt for floating point number
mov qword  rax, 0                                           ;No data from SSE will be printed
mov        rdi, stringformat                                ;"%s"
mov        rsi, promptmessage                               ;"Enter a floating point number in base 10: "
call       printf                                           ;Call a library function to make the output
pop rax                                                     ;Reverse an earlier push


;Obtain a floating point number from the standard input device and store a copy in xmm0
push qword 0                                                ;Reserve 8 bytes of storage for the incoming number
mov qword  rax, 0                                           ;SSE is not involved in this scanf operation
mov        rdi, eight_byte_format                           ;"%lf"
mov        rsi, rsp                                         ;Give scanf a point to the reserved storage
call       scanf                                            ;Call a library function to do the input work
movsd      xmm0, [rsp]                                      ;Copy the inputted number to xmm0
pop        rax                                              ;Make free the storage that was used by scanf

;Divide the inputted number by a constant
movsd      xmm2, xmm0                                       ;There are 2 copies of the inputted number: xmm0 and xmm2
mov        rbx, three_point_zero                            ;3.0 is placed in rbx, and is ready to be pushed on the stack.
push       rbx                                              ;Place the constant on the integer stack
divsd      xmm2, [rsp]                                      ;Divide the input number by the constant
movsd      xmm1, [rsp]                                      ;Copy the divisor to xmm1
pop        rax                                              ;Discard the divisor from the integer stack

;Save a copy of the quotient before calling printf
push qword 0                                                ;Reserve 8 bytes of storage
movsd      [rsp], xmm2                                      ;Place a backup copy of the quotient in the reserved storage

;Show the result of the division operation
mov        rax, 3                                           ;3 floating point numbers will be outputted
mov        rdi, outputmessage                               ;"The value of %1.18lf divided by %1.18lf is %1.18lf"
call       printf                                           ;Call a library function to do the hard work

;Output the concluding message
mov qword  rax, 0                                           ;No data from SSE will be printed
mov        rdi, stringformat                                ;"%s"
mov        rsi, goodbye                                     ;"This summation program will now return to the driver.  Have a nice day."
call       printf                                           ;Call a llibrary function to do the hard work.


;===== Retrieve a copy of the quotient that was backed up earlier =============================================================

pop        r14                                              ;A copy of the quotient is in r14 (temporary storage)

;Now the stack is in the same state as when the application area was entered.  It is safe to leave this application area.


;==============================================================================================================================
;===== Begin State Component Restore ==========================================================================================
;==============================================================================================================================

;Check the flag to determine if state components were really backed up
pop        rbx                                              ;Obtain a copy of the flag that indicates state component backup or not.
cmp        rbx, 0                                           ;If there was no backup of state components then jump past the restore section.
je         setreturnvalue                                   ;Go to set up the return value.

;Continue with restoration of state components;

;Precondition: edx:eax must hold the state component bitmap.  Therefore, go get a new copy of that bitmap.

;Preconditions for obtaining the bitmap from the cpuid instruction
mov        rax, 0x000000000000000d                          ;Place 13 in rax.  This number is provided in the Intel manual
mov        rcx, 0                                           ;0 is parameter for subfunction 0

;Call the function
cpuid                                                       ;cpuid is an essential function that returns information about the cpu

;Postcondition: The bitmap in now in edx:eax

;Future insurance: Make sure the bitmap is limited to a maximum of 3 state components.
mov        r15, 7
and        rax, r15
mov        r15, 0
and        rdx, r15

xrstor     [backuparea]

;==============================================================================================================================
;===== End State Component Restore ============================================================================================
;==============================================================================================================================


setreturnvalue:
push       r14                                              ;r14 continues to hold the first computed floating point value.
movsd      xmm0, [rsp]                                      ;That first computed floating point value is copied to xmm0[63-0]
pop        r14                                              ;Reverse the push of two lines earlier.

;Restore the original values to the GPRs
popf                                                        ;Restore rflags
pop        r15                                              ;Restore r15
pop        r14                                              ;Restore r14
pop        r13                                              ;Restore r13
pop        r12                                              ;Restore r12
pop        r11                                              ;Restore r11
pop        r10                                              ;Restore r10
pop        r9                                               ;Restore r9
pop        r8                                               ;Restore r8
pop        rdi                                              ;Restore rdi
pop        rsi                                              ;Restore rsi
pop        rdx                                              ;Restore rdx
pop        rcx                                              ;Restore rcx
pop        rbx                                              ;Restore rbx
pop        rbp                                              ;Restore rbp

ret                                                         ;No parameter with this instruction.  This instruction will pop 8 bytes from
                                                            ;the integer stack, and jump to the address found on the stack.
;========== End of program fp-io.asm ======================================================================================================================================
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**
