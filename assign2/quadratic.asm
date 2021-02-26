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
;  Programming languages: One file in C, Two files in C++, and one file in X86
;  Date program began:     2021-Feb-18
;  Date program completed: 2021-Feb-22
;  Date comments upgraded: 2021-Feb-22
;  Files in this program: second_degree.c, quadratic.asm, isfloat.cpp, quad_library.cpp
;  Status: Complete.  No errors found after extensive testing.
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
extern show_no_root
extern show_one_root
extern show_two_root

global quadratic

segment .data
floatformat db "%lf", 0                                                                                      ; Float Format
stringformat db "%s", 0                                                                                      ; Message Format
welcome db "This program will find the roots of any quadratic equation.", 10, 0                              ; Welcome Message
prompt db "Please enter the three floating point coefficients of a quadratic equation in the order a, b, c separated by white spaces.  Then press enter: ", 0 ; Prompt Message
equation db 10, "Thank you. The equation is %1.9lfx^2 + %1.9lfx + %1.9lf = 0.0", 10, 10, 0                   ; Display the equation
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
mov qword rdi, stringformat ; Put the string format into rdi
mov qword rsi, welcome      ; Put the welcome string into rsi
mov qword rax, 0            ; Put 0 into rax to signify that there are no variables
call printf                 ; Call printf

; Prompt Message
mov qword rdi, stringformat ; Put the string format into rdi
mov qword rsi, prompt       ; Put the prompt string into rsi
mov qword rax, 0            ; Put 0 into rax to signify that there are no variables
call printf                 ; Call printf

; Get First Input
push qword 0            ; Push qword to make register open
mov rdi, stringformat   ; Put string format into rdi
mov rsi, rsp            ; Point rsi at rsp
mov rax, 1              ; Put 1 into rax to specify that we want 1 string
call scanf              ; Call scanf

; Validate First Input
mov rdi, rsp            ; Point  rdi at rsp
mov rax, 0              ; Put 0 into rax to allow a returned bit
call isfloat            ; Call isfloat
cmp rax, 0              ; If rax is 0
je invalid              ; Jump to invalid

; Convert input to float
mov rax, 1              ; Move 1 into rax
call atof               ; call atof
movsd xmm10, xmm0       ; Copy the returned float into xmm10
pop rax                 ; pop rax register

; Get Second Input
push qword 0            ; Push qword to make register open
mov rdi, stringformat   ; Put string format into rdi
mov rsi, rsp            ; Point rsi at rsp
mov rax, 1              ; Put 1 into rax to specify that we want 1 string
call scanf              ; Call scanf

; Validate Second Input
mov rdi, rsp            ; Point  rdi at rsp
mov rax, 0              ; Put 0 into rax to allow a returned bit
call isfloat            ; Call isfloat
cmp rax, 0              ; If rax is 0
je invalid              ; Jump to invalid

; Convert input to float
mov rax, 1              ; Move 1 into rax
call atof               ; call atof
movsd xmm11, xmm0       ; Copy the returned float into xmm10
pop rax                 ; pop rax register

; Get Third Input
push qword 0            ; Push qword to make register open
mov rdi, stringformat   ; Put string format into rdi
mov rsi, rsp            ; Point rsi at rsp
mov rax, 1              ; Put 1 into rax to specify that we want 1 string
call scanf              ; Call scanf

; Validate Third Input
mov rdi, rsp            ; Point  rdi at rsp
mov rax, 0              ; Put 0 into rax to allow a returned bit
call isfloat            ; Call isfloat
cmp rax, 0              ; If rax is 0
je invalid              ; Jump to invalid

; Convert input to float
mov rax, 1              ; Move 1 into rax
call atof               ; call atof
movsd xmm12, xmm0       ; Copy the returned float into xmm10
pop rax                 ; pop rax register

; Print out the equation
push qword 0				; Make sure the registers are clear
mov rax, 3					; There is one variable
mov rdi, equation			;
movsd xmm0, xmm10			; move the value stored in xmm10 into xmm0
movsd xmm1, xmm11			; move the value stored in xmm11 into xmm1
movsd xmm2, xmm12			; move the value stored in xmm12 into xmm2
call printf					; call printf function
pop rax						; pop the stored value from push qword statement

; Find b^2-4ac
movsd xmm13, xmm11 ; Copy the "b" value into xmm13
mulsd xmm13, xmm11 ; Multiply xmm13 by xmm11 to get b^2
movsd xmm14, xmm10 ; Copy the "a" value into xmm14
mulsd xmm14, xmm12 ; Multiply xmm14 by xmm12, to get a*c
mov r8, 4          ; Put 4 into r8
cvtsi2sd xmm8, r8  ; Convert 4 into a float and store it in xmm8
mulsd xmm14, xmm8  ; Multiply xmm14 to get 4ac
subsd xmm13, xmm14 ; Subtract xmm14 from xmm13 to get b^2-4ac

; Compare b^2-4ac with 0 to find number of roots
mov r8, 0           ; Put 0 into r8
cvtsi2sd xmm8, r8   ; Convert r8 into xmm8
ucomisd xmm13, xmm8 ; Compare xmm13 to xmm8
jb zero_root        ; If below zero goto zero_root
je one_root         ; If equal to zero goto one_root
ja two_root         ; If above zero goto two_root

; Zero root - Call show_no_root
zero_root:
mov rax, 0
call show_no_root
mov r8, 0
cvtsi2sd xmm14, r8
jmp bye_block

; One root
one_root:
; Calculate root and store it in xmm14
mov r8, -1          ; Put -1 into r8
cvtsi2sd xmm8, r8   ; Convert r8 into float
mulsd xmm11, xmm8   ; multiple xmm11 by -1 to get -b
mov r8, 2           ; Put 2 into r8
cvtsi2sd xmm8, r8   ; Call r8 into float
mulsd xmm10, xmm8   ; Multiple xmm10 by 2 to get 2a
divsd xmm11, xmm10  ; Divide xmm11 by xmm10 to get -b/2a
movsd xmm14, xmm11  ; Put xmm11 into xmm14

; Call show_one_root
push qword 0
mov rax, 1          ; Put 1 into rax to signify 1 root
movsd xmm0, xmm14   ; Put xmm14 into xmm0 to pass it to the function
call show_one_root  ; call show_one_root
pop rax
jmp bye_block       ; Jump to the bye block

; Two root - Call show_two_root
two_root:
; Set up calculations to find roots
mov r8, -1          ; Put -1 into r8
cvtsi2sd xmm8, r8   ; Convert r8 into float
mulsd xmm11, xmm8   ; multiple xmm11 by -1 to get -b
mov r8, 2           ; Put 2 into r8
cvtsi2sd xmm8, r8   ; Call r8 into float
mulsd xmm10, xmm8   ; Multiple xmm10 by 2 to get 2a
sqrtsd xmm13, xmm13 ; Get the square root of xmm13

; Find the first root and store it in xmm14
movsd xmm14, xmm11  ; Move xmm11 to xmm14   - xmm14 holds 2a
addsd xmm14, xmm13  ; Add xmm14 and xmm13   - xmm14 holds 2a+sqrt(b^2-4ac)
divsd xmm14, xmm10  ; Divide xmm14 by xmm10 - xmm14 holds 2a+sqrt(b^2-4ac) / 2a

; Find the second root and store it in xmm15
movsd xmm15, xmm11  ; Move xmm11 to xmm15   - xmm15 holds 2a
subsd xmm15, xmm13  ; Add xmm15 and xmm13   - xmm15 holds 2a-sqrt(b^2-4ac)
divsd xmm15, xmm10  ; Divide xmm15 by xmm10 - xmm15 holds 2a-sqrt(b^2-4ac) / 2a

; Call show_two_root
push qword 0
mov rax, 2          ; Signify that there are 2 variables
movsd xmm0, xmm14   ; Put xmm14 into xmm0 to pass it to the function
movsd xmm1, xmm15   ; Put xmm15 into xmm1 to pass it to the function
call show_two_root  ; call show_two_root
pop rax

bye_block:
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
pop rax

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

movsd xmm0, xmm14
ret