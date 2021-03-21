;*****************************************************************************************************************************
;Program name: "Sum of an Array".  This program demonstrates how to input an unknown amount of floats and sum them all       *
;together.  Copyright (C) 2021 Luke Eltiste                                                                                  *
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License   *
;version 3 as published by the Free Software Foundation.                                                                     *
;This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied          *
;Warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.      *
;A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                            *
;*****************************************************************************************************************************

;=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;
;Author information
;  Author name: Luke Eltiste
;  Author email: lukeeltiste@csu.fullerton.edu
;
;Program information
;  Program name: Sum of an Array
;  Programming languages: One modules in C++, three modules in X86, and one module in C
;  Date program began:     2021-Mar-08
;  Date program completed: 2021-Mar-14
;  Date comments upgraded: 2021-Mar-20
;  Files in this program: control.asm, display.cpp, fill.asm, main.c, script.sh, and sum.asm
;  Status: Complete.  No errors found after extensive testing.
;
;References for this program
;  Jorgensen, X86-64 Assembly Language Programming with Ubuntu, Version 1.1.40.
;
;Purpose
;  Show how to take user input and store it into an array and then do math on those floats
;
;This file
;   File name: fill.asm
;   Language: X86-64 with Intel syntax
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l fill.lis -o fill.o fill.asm
;   Link: gcc -m64 -no-pie -o assign3.out -std=c++17 main.o control.o fill.o sum.o display.o
;   Optimal print specification: 132 columns width, 7 points, monospace, 8½x11 paper

extern scanf
extern printf

global fill

segment .data
start db "Please enter floating point numbers separated by ws.", 10, "When finished press enter followed by cntl+D.", 10, 0
format db "%lf", 0
stringformat db "%s", 0

segment .text
fill:

;Back up the general purpose registers for the sole purpose of protecting the data of the caller.
push rbp                                                    ;Backup rbp
mov  rbp,rsp                                                ;The base pointer now points to top of stack
push rdi                                                    ;Backup rdi
push rsi                                                    ;Backup rsi
push rdx                                                    ;Backup rdx
push rcx                                                    ;Backup rcx
push r8                                                     ;Backup r8
push r9                                                     ;Backup r9
push r10                                                    ;Backup r10
push r11                                                    ;Backup r11
push r12                                                    ;Backup r12
push r13                                                    ;Backup r13
push r14                                                    ;Backup r14
push r15                                                    ;Backup r15
push rbx                                                    ;Backup rbx
pushf                                                       ;Backup rflags

;There are 15 pushes above.  Make one more push of any value so that the number of pushes is an even number
push qword -1                                               ;Now the number of pushes is even
;Registers rax, rip, and rsp are usually not backed up.

; Grab inputs
mov r15, rdi ;r15 is now the array
mov r14, rsi ;r14 is now the max number of elements in the array
mov r13, 0   ;r13 is the for loop counter

; Print a loop instructions
push qword 0
mov qword rdi, stringformat
mov qword rsi, start
mov qword rax, 0
call printf

; Input loop
beginloop:
cmp r13, r14    ; r13 = count, r14 = max
jge exit        ; Leave loop if array is full

; Get user input
mov rdi, format
push qword 0
mov rsi, rsp
mov rax, 0
call scanf

; Check for ctrl-D
cdqe            ; Signal in all of rax
cmp rax, -1
je leaveloop    ; Leave the loop because ctrl-D was entered

; Put input in the array
movsd xmm15, xmm0               ; Put input into r12
movsd [r15 + 8 * r13], xmm15    ; Add input to array
inc r13
pop rax
jmp beginloop                   ; End of loop

; Exit of loop
leaveloop:
pop rax
exit:
pop rax

;Restore the original values to the general registers before returning to the caller.
pop rax                                                     ;Remove the extra -1 from the stack
mov rax, r13                                                ; Copy number of elements to rax
popf                                                        ;Restore rflags
pop rbx                                                     ;Restore rbx
pop r15                                                     ;Restore r15
pop r14                                                     ;Restore r14
pop r13                                                     ;Restore r13
pop r12                                                     ;Restore r12
pop r11                                                     ;Restore r11
pop r10                                                     ;Restore r10
pop r9                                                      ;Restore r9
pop r8                                                      ;Restore r8
pop rcx                                                     ;Restore rcx
pop rdx                                                     ;Restore rdx
pop rsi                                                     ;Restore rsi
pop rdi                                                     ;Restore rdi
pop rbp                                                     ;Restore rbp

ret