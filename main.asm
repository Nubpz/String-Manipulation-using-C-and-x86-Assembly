extern display
extern	read
extern	freeUp
extern printf	
extern reversehalves
extern	scramble
extern	findnreplace
	
	section .data
	
menu:
	db 10
	db "d/D: Display", 10
	db "u/U: Update", 10
	db "f/F: Find & Replace", 10
	db "t/T: Transform", 10
	db "e/E: Exit", 10
	db "--------------",10
	db "Enter your choice",10
	
len_menu:	equ	$-menu

error:  	db	"Invalid option! Try again! ", 10
err_len:	equ	 $-error
	
update:		db	"Please enter the text: ", 10, 0
up:		equ	 $-update

transform:	db	"Please enter the number of the string you would like to work with: ", 10
trans:		equ	$-transform

messages:       dq      msg0, msg1, msg2, msg3, msg4, msg5, msg6, msg7, msg8, msg9
	
msg0:		dq 	"I love assembly language and CMSC 313 is my favorite class at UMBC!",0, 10
msg1:           dq      "I love assembly language and CMSC 313 is my favorite class at UMBC!",0, 10
msg2:           dq      "I love assembly language and CMSC 313 is my favorite class at UMBC!",0, 10
msg3:           dq      "I love assembly language and CMSC 313 is my favorite class at UMBC!",0, 10
msg4:           dq      "I love assembly language and CMSC 313 is my favorite class at UMBC!",0, 10
msg5:           dq      "I love assembly language and CMSC 313 is my favorite class at UMBC!",0, 10
msg6:           dq      "I love assembly language and CMSC 313 is my favorite class at UMBC!",0, 10
msg7:           dq      "I love assembly language and CMSC 313 is my favorite class at UMBC!",0, 10
msg8:           dq      "I love assembly language and CMSC 313 is my favorite class at UMBC!",0, 10
msg9:           dq      "I love assembly language and CMSC 313 is my favorite class at UMBC!",0, 10


	section .bss

menu_string:	resb	2
arr:		resq  	10
indx:		resb	2
find_indx:	resb	2

	section .text

	global main

main:
	xor	r8,r8
	xor	r9,r9
init:
	mov 	rax, qword[messages + r8] 
	mov 	qword[arr + r8], rax       
	add 	r8, 8	
	cmp 	r8, 80	
	jl 	init
	
	xor	r13, r13

	mov	byte[indx], 3
	
menus:
	xor 	rax, rax

	mov	rax, 1
	mov	rdi, 1
	mov	rsi, menu
	mov	rdx, len_menu
	syscall

	mov	rax, 0
	mov	rdi, 0
	mov	rsi, menu_string
	mov	rdx, 2
	syscall

	
	cmp	byte[menu_string], 'd'
	je	Displays

	cmp	byte[menu_string], 'D'
        je	Displays


	cmp     byte[menu_string], 'u'
        je      Update

        cmp     byte[menu_string], 'U'
        je      Update

	cmp     byte[menu_string], 'f'
        je      FindnReplace

        cmp     byte[menu_string], 'F'
        je      FindnReplace

	cmp     byte[menu_string], 't'
        je      Transform

        cmp     byte[menu_string], 'T'
        je      Transform

	cmp     byte[menu_string], 'e'
        je      exit

        cmp     byte[menu_string], 'E'
        je      exit
	
	mov     rax, 1
        mov     rdi, 1
        mov     rsi, error
        mov     rdx, err_len
        syscall

	jmp	menus

Displays:
	mov	rdi, arr
	call	display
	
	jmp 	menus
	
Update:
	mov     rax, 1
        mov     rdi, 1
        mov     rsi, update
        mov     rdx, up
        syscall
	
	xor	rdi,rdi
	mov	rdi, qword[arr+r13]
	
	call	read

	cmp	qword[arr+r13], rax
	je	invalidInput

	mov	qword[arr+r13], rax

	xor 	rax, rax
	
	add	r13, 8

	inc	r9
	
	cmp	r13, 80
	je	reset

	jmp	menus
	
reset:
	xor	r13, r13
	jmp 	menus

invalidInput:
	mov     qword[arr+r13], rax
	xor	rax, rax
	jmp	menus
	
FindnReplace:	
	mov     rax, 1
        mov     rdi, 1
        mov     rsi, transform
        mov     rdx, trans
        syscall

        mov     rax, 0
        mov     rdi, 0
        mov     rsi, find_indx
        mov     rdx, 2
        syscall

        xor     rax, rax
        mov     al, [find_indx]
        sub     al, 48
        xor     r12, r12
        mov     r12, 8
        mul     r12

        xor     r15, r15
        mov     r15, rax

        xor     rax, rax

        xor     rdi, rdi
        mov     rdi, qword[arr+r15]

        call    findnreplace

        xor     r15, r15
	xor	rdi, rdi
        xor     rax, rax
        jmp     menus	

Transform:
	mov     rax, 1
        mov     rdi, 1
        mov     rsi, transform
        mov     rdx, trans
        syscall

	mov     rax, 0
        mov     rdi, 0
        mov     rsi, menu_string
        mov     rdx, 2
        syscall

	xor	rax, rax
	mov	al, [menu_string]
	sub	al, 48
	xor	r12, r12
	mov	r12, 8
	mul	r12

	xor	r12, r12
	mov	r12, rax

	xor 	rax, rax
	

maxrand:
	mov	rax, [indx]
	;Generates the random number based on the function provided
	xor	rcx,rcx
	mov	rcx,1103515245
	mul	rcx
	add	rax,12345

	mov	rbx,65536
	xor	rdx,rdx
	div	rbx

	xor 	rdx, rdx
	mov	r8,98		;max = 98
	inc	r8

	;divides rax by 20 and stores remainder in rdx  
	div	r8		
	mov 	r10, rdx	
	mov	[indx], rdx
	
rand_select:
	;Selects transformation randomly based on the generated random number
	xor	rax,rax
	xor	rdx,rdx

	mov	rax,r10
	mov 	r11, 2
	div 	r11

	
	; If odd perform reversehalves else scramble 
	cmp	rdx,1
	je	transform_reversehalf

	jmp	transform_scramble
	
transform_reversehalf:
	xor     rax, rax
        xor     rdi, rdi
        mov     rdi, qword[arr+r12]

	call	reversehalves
	jmp 	 menus
	
transform_scramble:
	xor     rax, rax
        xor     rdi, rdi
        mov     rdi, qword[arr+r12]
	
	call	scramble

	jmp menus

exit:
	mov 	rdi, arr
	xor	rsi, rsi
	mov	rsi, r9
	call	freeUp
	xor	rax, rax
	
	
	xor	rsi, rsi	
	mov	rax, 60
	xor	rdi,rdi
	syscall
