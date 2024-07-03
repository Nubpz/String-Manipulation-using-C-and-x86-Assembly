	section .data
info:          db      "The text is reverse-halved as: ", 0
info_len:      equ      $-info

new_line        db      10
	
	section .text
	global reversehalves

reversehalves:
	xor	 r10,r10
	xor	 r14,r14
	
	mov	 r10,rdi
	mov	 r14, rdi
	
	xor	r15,r15
find_length:
	mov	al, [r10+r15]
	cmp	al,0
	je	reverse
	inc	r15
	jmp	find_length

reverse:	
	xor	r12, r12
	mov	r12, r15

	shr	r12, 1

	add	r10, r12
	
	xor	r12,r12
	mov	r12,r10

	add	r15, r14
	sub	r15,1

	xor	rdi, rdi

	dec	r10

	mov     rax,1
        mov     rdi,1
        mov     rsi,info
        mov     rdx,info_len
        syscall
	
printFirstHalf:
	mov	rax,1
	mov	rdi,1
	mov	rsi,r10
	mov	rdx,1
	syscall

	dec	r10
	cmp	r10, r14
	jge	printFirstHalf

	jmp	printSecondHalf

printSecondHalf:
	mov     rax,1
        mov     rdi,1
        mov     rsi,r15
        mov     rdx,1
        syscall

        dec     r15
        cmp     r15, r12
        jge     printSecondHalf

	mov     rax, 1
        mov     rdi, 1
        mov     rsi, new_line
        mov     rdx, 1
        syscall

	xor	rax,rax
	xor	rdx,rdx
	xor	rdi,rdi
	xor	rsi,rsi
	xor	r15,r15
       
	ret

	
	
