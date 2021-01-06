include irvine32.inc
.data
txt1 BYTE "Enter a Multiplier : ",0
txt2 BYTE "Enter a Multiplicand : ",0
txt3 BYTE "Product : ",0
Bye BYTE "Bye!",0
shift_num BYTE 0
ans DWORD 0
.code
BitwiseMultiply PROC
;ebx*eax=>eax
mov ans,0 ;�ʱ�ȭ
mov edx, OFFSET txt1
call WriteString
call ReadHex
cmp eax,0
je L1
push eax
mov edx, OFFSET txt2
call WriteString
call ReadHex
mov ebx,eax
pop eax;��������� multiplier�̶�  multiplicand�Է¹�����
mov shift_num,0;�� �ʱ�ȭ
mov ecx,32
L2:
	shr eax,1
	jnc L3
	push ecx
	mov cl,shift_num
	shl ebx,cl
	pop ecx
	add ans,ebx
	mov shift_num,0
L3: 
	add shift_num,1
	loop L2
	mov eax,1 ;eax�� 0�̸� �������� ���α׷�������
L1:
ret
BitwiseMultiply ENDP



main PROC
beginwhile:
	call BitwiseMultiply
	cmp eax,0
	je endwhile
	mov edx, OFFSET txt3
	call WriteString
	mov eax,ans
	call WriteHex
	call Crlf
	call Crlf
	call Crlf
jmp beginwhile
endwhile:
	mov edx, OFFSET Bye
	call WriteString
	call Crlf
exit
main ENDP
END main