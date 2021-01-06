include irvine32.inc

.data
include hw3.inc
CODE_A BYTE '1'
CODE_B BYTE '01'
CODE_C BYTE '000'
CODE_D BYTE '0011'
CODE_E BYTE '0010'
ans BYTE 0			;지금까지 n단어를 검색했는지 표시
n DWORD 10  ;개행문자

.code
find_al PROC
;해당하는 알파벳이 무엇인지 프린트하는 프로시저
mov ans,0
L1:
	inc ans
	shl ebx,1
	jc La;1
	inc ans
	shl ebx,1
	jc Lb;01
	inc ans
	shl ebx,1
	jnc Lc;000
	inc ans
	shl ebx,1
	jc Ld
	jmp Le_

La: cmp ans,32
	jg L2
	mov al,'A'
	call WriteChar
	jmp L1
Lb: cmp ans,32
	jg L2
	mov al,'B'
	call WriteChar
	jmp L1
Lc: cmp ans,32
	jg L2
	mov al, 'C'
	call WriteChar
	jmp L1
Ld:	cmp ans,32
	jg L2
	mov al, 'D'
	call WriteChar
	jmp L1
Le_: cmp ans,32
	jg L2
	mov al,'E'
	call WriteChar
	jmp L1
L2:
ret
find_al ENDP


main PROC
mov ebx,CODE01
call find_al
mov eax,n
call WriteChar
mov ebx,CODE02
call find_al
mov eax,n
call WriteChar
mov ebx,CODE03
call find_al
mov eax,n
call WriteChar
mov ebx,CODE04
call find_al
mov eax,n
call WriteChar
mov ebx,CODE05
call find_al
exit
main ENDP
END main