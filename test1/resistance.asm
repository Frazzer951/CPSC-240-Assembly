; Luke Eltiste
; CPSC240-5 Test 1

extern printf
extern scanf

global resistance

segment .data
floatformat db "%lf", 0
stringformat db "%s", 0
prompt db "Please enter the resistance numbers of the three subcircuits separated by ws and press enter.", 10, 0
resistances db "These resistances were received: %1.9lf Ω,  %1.9lf Ω,  %1.9lf Ω", 10, 0

segment .text
resistance:

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

; Prompt Message
mov qword rdi, stringformat
mov qword rsi, prompt
mov qword rax, 0
call printf

; Take the first input and enter it into xmm10
mov rax, 1
mov rdi, floatformat
push qword 0
mov rsi, rsp
call scanf
movsd xmm10, [rsp]
pop rax

;  Take the second input and enter it into xmm11
mov rax, 1
mov rdi, floatformat
push qword 0
mov rsi, rsp
call scanf
movsd xmm11, [rsp]
pop rax

;  Take the third input and enter it into xmm12
mov rax, 1
mov rdi, floatformat
push qword 0
mov rsi, rsp
call scanf
movsd xmm12, [rsp]
pop rax

; Print out the resistances
push qword 0
mov rax, 3
mov rdi, resistances
movsd xmm0, xmm10
movsd xmm1, xmm11
movsd xmm2, xmm12
call printf
pop rax

; Get the inverse of the resistances
mov r8, 1
cvtsi2sd xmm8, r8
divsd xmm8, xmm10
movsd xmm10, xmm8

cvtsi2sd xmm8, r8
divsd xmm8, xmm11
movsd xmm11, xmm8

cvtsi2sd xmm8, r8
divsd xmm8, xmm12
movsd xmm12, xmm8

; Add the inverse resistances into xmm13
movsd xmm13, xmm10
addsd xmm13, xmm11
addsd xmm13, xmm12

; Inverse the result to get the resistance
mov r8, 1
cvtsi2sd xmm8, r8
divsd xmm8, xmm13
movsd xmm13, xmm8

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

movsd xmm0, xmm13
ret