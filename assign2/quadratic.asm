;*****************************************************************************************************************************
;Program name: "assign2".  This program will take the 3 parts of a quadradtic equation and return the roots  Copyright (C) 2021 Luke Eltiste *
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License   *
;version 3 as published by the Free Software Foundation.                                                                     *
;This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied          *
;Warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.      *
;A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                            *
;*****************************************************************************************************************************
;=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;Author information
;  Author name: Luke Eltiste
;  Author email: lukeeltiste@csu.fullerton.edu
;
;Program information
;  Program name: assign2
;  Programming languages: TODO
;  Date program began:     2021-Feb-18
;  Date program completed: 
;  Date comments upgraded: 
;  Files in this program: second_degree.c, quadratic.asm, isfloat.cpp, quad_library.cpp
;  Status: In Development.
;
;References for this program
;  Jorgensen, X86-64 Assembly Language Programming with Ubuntu, Version 1.1.40.
;
;Purpose
;  To demonstatrate how to do floating point arithmetic and how to call external functions from an assembly file
;
;This file
;   File name: quadratic.asm
;   Language: X86-64 with Intel syntax
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l quadratic.lis -o quadratic.o quadratic.asm
;   Link: gcc -m64 -no-pie -o assign2.out -std=c++17 second_degree.o quadratic.o isfloat.o quad_library.o 
;   Optimal print specification: 132 columns width, 7 points, monospace, 8�x11 paper

extern printf
extern scanf
extern isfloat
extern atof

global quadratic

segment .data
floatformat db "%lf", 0                                                                                      ; Float Format
stringformat db "%s", 0                                                                                      ; Message Format
welcome db "This program will find the roots of any quadratic equation.", 10, 0                              ; Welcome Message
prompt db "Please enter the three floating point coefficients of a quadratic equation in the order a, b, c separated by white spaces.  Then press enter: ", 0 ; Prompt Message
equation db 10, "Thank you. The equation is %lfx^2 + %lfx + %lf = 0.0", 10, 10, 0                            ; Display the equation
invalidstr db 10, "Invalid input data detected.  You may run this program again.", 10 , 10, 0                ; Invalid input
bye db "One of these roots will be returned to the caller function.", 10, 0                                  ; Goodbye statement

segment .text
quadratic:

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

; Prompt Message
mov qword rdi, stringformat
mov qword rsi, prompt
mov qword rax, 0
call printf

; Get First Input
push qword 0
mov rdi, stringformat
mov rsi, rsp
mov rax, 1
call scanf

; Validate First Input
mov rdi, rsp
mov rax, 0
call isfloat
cmp rax, 0
je invalid

; Convert input to float
mov rax, 1
call atof
movsd xmm10, xmm0
pop rax

; Get Second Input
push qword 0
mov rdi, stringformat
mov rsi, rsp
mov rax, 1
call scanf

; Validate Second Input
mov rdi, rsp
mov rax, 0
call isfloat
cmp rax, 0
je invalid

; Convert input to float
mov rax, 1
call atof
movsd xmm11, xmm0
pop rax

; Get Third Input
push qword 0
mov rdi, stringformat
mov rsi, rsp
mov rax, 1
call scanf

; Validate Third Input
mov rdi, rsp
mov rax, 0
call isfloat
cmp rax, 0
je invalid

; Convert input to float
mov rax, 1
call atof
movsd xmm12, xmm0
pop rax

; Print string with one variable
push qword 0				; Make sure the registers are clear
mov rax, 3					; There is one variable
mov rdi, equation			;
movsd xmm0, xmm10			; move the value stored in xmm10 into xmm0
movsd xmm1, xmm11			; move the value stored in xmm11 into xmm1
movsd xmm2, xmm12			; move the value stored in xmm12 into xmm2
call printf					; call printf function
pop rax						; pop the stored value from push qword statement


; Goodbye Message
mov qword rdi, stringformat
mov qword rsi, bye
mov qword rax, 0
call printf

jmp end ; skip past invalid block
; Invalid Input
invalid:
mov qword rdi, stringformat
mov qword rsi, invalidstr
mov qword rax, 0
call printf

end:
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

movsd xmm0, xmm0
ret