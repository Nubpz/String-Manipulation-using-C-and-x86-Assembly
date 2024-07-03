        section .data
info:          db      "The text is scrambled as: ", 0
info_len:      equ      $-info

new_line        db      10

        section .text
        global scramble

scramble:
        xor      r10,r10
        xor      r14,r14

        mov      r10,rdi
        mov      r14, rdi

        xor     r15,r15

find_length:
        mov     al, [r10+r15]
        cmp     al,0
        je      end_char
        inc     r15
        jmp     find_length

end_char:	
        add     r14,r15
        dec     r14

	mov     rax, 1
        mov     rdi, 1
        mov     rsi, info
        mov     rdx, info_len
        syscall
print:	
        mov     rax, 1
        mov     rdi, 1
        mov     rsi, r10
        mov     rdx, 1
        syscall

        mov     rax, 1
        mov     rdi, 1
        mov     rsi, r14
        mov     rdx, 1
        syscall

	;validates if the number of characters in the string is odd or even
	dec     r14
        cmp     r14,r10
        je      newline

        inc     r14
   
        inc     r10
        dec     r14
        cmp     r14,r10
        jg      print

	mov     rax, 1
        mov     rdi, 1
        mov     rsi, r14
        mov     rdx, 1
        syscall


newline:
        ;prints new line                                                                                                              
        mov     rax, 1
        mov     rdi, 1
        mov     rsi, new_line
        mov     rdx, 1
        syscall

        ret
