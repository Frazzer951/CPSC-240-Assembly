extern scanf

segment .data
sixty4bitform db "%lf", 0

mov rax, 1
mov rdi, sixty4bitform
push qword 0
mov rsi rsp
call scanf
movsd xmm13, [rsp]
pop rax