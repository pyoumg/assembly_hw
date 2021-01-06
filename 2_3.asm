TITLE search the word

include irvine32.inc
.data



p_str1 BYTE "Type_A_String:",0
p_str2 BYTE "A_Word_for_Search:",0
sr BYTE 50 DUP(?)
str_len DWORD 0
wrd BYTE 41 DUP(?)
word_len DWORD 0
f BYTE "Found",0
n_f BYTE "Not found",0
n DWORD 10  ;개행문자
bye BYTE "Bye!",0 
nu BYTE 32;공백

.code
search PROC
;문장에 단어가 있는지 찾는 프로시저
;receives;esi(문장 인덱스)
;return: eax(1이면 찾은거 0이면 못찾은거)

mov edx,0
mov eax,0
mov ecx,word_len
L1:
	mov bl,wrd[edx]
	cmp bl,sr[esi]
	jne L3
	inc esi
	inc edx
	loop L1
L2: mov eax,1

L3:
ret
search ENDP

alp PROC
;check if al is alphabet
;receives: al
;returns: al(1:alphabet 0: not)
cmp al,64
jl L1
cmp al,122
jg L1
cmp al,91
jg L2
jmp L3
L2:cmp al,97
	jl L1
	jmp L3
L1:mov al,0
jmp L4
L3:mov al,1
L4:

ret
alp ENDP

main PROC
beginwhile:
mov edx, OFFSET p_str1
call WriteString
mov edx, OFFSET sr
mov ecx, SIZEOF sr-1	
call ReadString
mov str_len,eax

cmp eax,1
jl  endwhile

cmp eax,40
jg beginwhile

mov edx, OFFSET p_str2
call WriteString
mov edx, OFFSET wrd
mov ecx, SIZEOF wrd-1	
call ReadString

mov word_len,eax
mov ecx,str_len
sub ecx,word_len 
add ecx,1
mov esi,0

L1:
	mov eax,0
	push ecx
	push esi
	call search
	pop esi
	pop ecx
	cmp eax, 0
	jg L2_1
	inc esi	
	loop L1

	jmp L3 

L2_1: 
	cmp esi,0
	je L2_2
	mov edx,esi
	sub edx,1 
	mov al,nu
	cmp al,sr[edx]
	je L2_2
	mov al,sr[edx]
	call alp
	cmp al,1
	je L2_4;if it is alphabet

L2_2:
	cmp ecx,1
	je L2_3
	mov edx,esi
	add edx,word_len
	mov al,nu
	cmp al,sr[edx] 
	je L2_3
	mov al,sr[edx]
	call alp
	cmp al,1
	je L2_4
	
L2_3:;print "found"
mov edx, OFFSET f
	call WriteString
	mov eax,n
	call WriteChar
	jmp L4
L2_4:
	inc esi
	cmp ecx,1
	jg L1
L3:
	mov edx, OFFSET n_f
	call WriteString
	mov eax,n
	call WriteChar
L4:
	jmp beginwhile
endwhile:
	mov edx, OFFSET bye
	call WriteString
exit
main ENDP
END main