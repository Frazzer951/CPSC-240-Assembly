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
;   File name: control.asm
;   Language: X86-64 with Intel syntax
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l control.lis -o control.o control.asm
;   Link: gcc -m64 -no-pie -o assign3.out -std=c++17 main.o control.o fill.o sum.o display.o
;   Optimal print specification: 132 columns width, 7 points, monospace, 8½x11 paper

extern printf
extern fill
extern display
extern sum

array_size equ 100 ; Max size for the array

global control

segment .data
stringFormat db "%s", 0
welcome db "Welcome to HSAS.  The accuracy and reliability of this program is guaranteed by Luke E.", 10, 0
numbers db "The number you entered are these:", 10, 0
the_sum db "The sum of these values is %1.8lf", 10, 0
exit db "The control module will now return the sum to the caller module.", 10, 0

section .bss
array: resq 100

segment .text
control:

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

; Print a welcome message
mov qword rdi, stringFormat
mov qword rsi, welcome
mov qword rax, 0
call printf

; Fill array
mov qword rdi, array      ; Pass the array to the fill function
mov qword rsi, array_size ; Pass the max size to the fill function
mov qword rax, 0
call fill           ; Call the fill function
mov r15, rax        ; Save the size of the array to r15

; Print numbers
mov qword rdi, stringFormat
mov qword rsi, numbers
mov qword rax, 0
call printf

; Display the Array
push qword 0
mov rdi, array  ; Pass the array to the display function
mov rsi, r15    ; Pass the array size to the display function
mov rax, 0
call display    ; Call the display function
pop rax

; Sum the array
mov rdi, array      ; Pass the array to the sum function
mov rsi, r15        ; Pass the array size to the sum function
mov rax, 0
call sum            ; Call the sum function
movsd xmm15, xmm0    ; Save the sum to xmm15

; Print the sum value
push qword 0
mov rax, 1
mov rdi, the_sum
movsd xmm0, xmm15
call printf
pop rax

; Print exit message
mov qword rdi, stringFormat
mov qword rsi, exit
mov qword rax, 0
call printf

; Return values
movsd xmm0, xmm15

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

ret