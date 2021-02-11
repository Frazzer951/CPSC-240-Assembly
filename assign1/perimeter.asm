;*****************************************************************************************************************************
;Program name: "Perimiter of a Rectangle".  This program demonstrates how to input and output float data and how to perform  *
;form a few simple operations on floats.  Copyright (C) 2021 Luke Eltiste                                                    *
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
;  Program name: Perimiter of a Rectangle
;  Programming languages: One modules in C++ and one module in X86
;  Date program began:     2021-Jan-28
;  Date program completed: 2021-Feb-09
;  Date comments upgraded: 2021-Feb-09
;  Files in this program: rectangle.cpp, perimiter.asm, run.sh
;  Status: Complete.  No errors found after extensive testing.
;
;References for this program
;  Jorgensen, X86-64 Assembly Language Programming with Ubuntu, Version 1.1.40.
;  Robert Plantz, X86 Assembly Programming.  [No longer available as a free download]
;
;Purpose
;  Show how to perform arithmetic operations on float data types
;
;This file
;   File name: perimiter.asm
;   Language: X86-64 with Intel syntax
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l perimiter.lis -o perimiter.o perimiter.asm
;   Link: gcc -m64 -no-pie -o perimiterOfRectangle.out -std=c++17 perimiter.o rectangle.o
;   Optimal print specification: 132 columns width, 7 points, monospace, 8½x11 paper

extern printf
extern scanf

null equ 0
newline equ 10

global perimeter

segment .data

welcome db "This program will compute the perimeter and the average side length of a rectangle.", newline, null ; Welcome Message
floatformat db "%lf", null                                                                                      ; Float Format
stringformat db "%s", null                                                                                      ; Message Format
enterheight db "Enter the height:   ", null                                                                     ; Ask for height
enterwidth db "Enter the width:    ", null                                                                      ; Ask for width
perimeterprint db "The perimeter is %1.2lf", newline, null                                                      ; Print the perimeter
avglength db "The length of the average side is %1.2lf", newline, null                                          ; Print the average side
enjoyrec db "I hope you enjoyed your rectangle", newline, null                                                  ; Goodbye Message
return db "The assembly program will send the perimeter to the main function.", newline, null                   ; Return Message

segment .text
perimeter:

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

; Welcome Message
mov qword rdi, stringformat
mov qword rsi, welcome
mov qword rax, 0
call printf

; Prompt for height
mov qword rdi, stringformat
mov qword rsi, enterheight
mov qword rax, 0
call printf

; Take height input and enter it into xmm10
mov rax, 1
mov rdi, floatformat
push qword 0
mov rsi, rsp
call scanf
movsd xmm10, [rsp]
pop rax

; Prompt for width
mov qword rdi, stringformat
mov qword rsi, enterwidth
mov qword rax, 0
call printf

; Take width input and enter it into xmm11
mov rax, 1
mov rdi, floatformat
push qword 0
mov rsi, rsp
call scanf
movsd xmm11, [rsp]
pop rax

; Find the perimiter
movsd xmm12, xmm10
addsd xmm12, xmm10
addsd xmm12, xmm11
addsd xmm12, xmm11

; Print out the perimiter
push qword 0
mov rax, 1
mov rdi, perimeterprint
movsd xmm0, xmm12
call printf
pop rax

; Find the average side length
mov r8, 4
cvtsi2sd xmm8, r8
movsd xmm13, xmm12
divsd xmm13, xmm8

; Print out the perimiter
push qword 0
mov rax, 1
mov rdi, avglength
movsd xmm0, xmm13
call printf
pop rax

; Return Message
mov qword rdi, stringformat
mov qword rsi, return
mov qword rax, 0
call printf

;Restore the original values to the general registers before returning to the caller.
pop rax                                                     ;Remove the extra -1 from the stack
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

movsd xmm0, xmm12
ret