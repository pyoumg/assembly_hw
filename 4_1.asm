include irvine32.inc

.data
p_text1 BYTE "Enter a plain text : ",0
p_text2 BYTE "Enter a key : ",0
p_text3 BYTE "Original Text : ",0
p_text4 BYTE "Encrypted Text : ",0
p_text5 BYTE "Decrypted Text : ",0
key BYTE 42 DUP(?)
key_len DWORD 0
txt_len DWORD 0
num_key DWORD 0
new_key BYTE 12 DUP(0)
txt BYTE 42 DUP(?)
bye BYTE "Bye!",0
.code

enc PROC;encryption�� ����ϴ� ���ν��� edx�� Ű �ε��� (��������) ��
	mov ecx,txt_len
	mov esi,0
	
L_enc:
	mov edx,0
	mov eax,esi
	div num_key;edx�� key�ε����� ����
	cmp new_key[edx],0
	jl L_enc_minus
	cmp new_key[edx],0
	jg L_enc_plus ;0�̸� �ƹ��͵� ���ص� ��
	inc esi
	loop L_enc
	jmp L_enc_end;���� ������
	L_enc_minus:
				push ecx
				mov cl,new_key[edx]
				neg cl
				rol txt[esi],cl
				inc esi
				pop ecx
				dec ecx
				cmp ecx,0
				jle L_enc_end
				jmp L_enc
	L_enc_plus: push ecx
				mov cl,new_key[edx]
				ror txt[esi],cl
				inc esi
				pop ecx
				dec ecx
				cmp ecx,0
				jle L_enc_end
				jmp L_enc
L_enc_end:
ret
enc ENDP

decre PROC;decryption�� ����ϴ� ���ν��� edx�� Ű �ε��� (��������) ��
	mov ecx,txt_len
	mov esi,0
	
L_dec:
	mov edx,0
	mov eax,esi
	div num_key;edx�� key�ε����� ����
	cmp new_key[edx],0
	jl L_dec_minus
	jg L_dec_plus;0�̸� �ƹ��͵� ���ص� ��
	inc esi
	loop L_dec
	jmp L_dec_end;���� ������
	L_dec_minus:
				push ecx
				mov cl,new_key[edx]
				neg cl
				ror txt[esi],cl
				inc esi
				pop ecx
				dec ecx
				cmp ecx,0
				jle L_dec_end
				jmp L_dec
	L_dec_plus: 
				push ecx
				mov cl,new_key[edx]
				rol txt[esi],cl
				inc esi
				pop ecx
				dec ecx
				cmp ecx,0
				jle L_dec_end
				jmp L_dec
L_dec_end:
ret
decre ENDP


getkey PROC;Ű�� �����ϴ� ���ν���
mov num_key,0
mov esi,0
L_key:
	cmp	esi,0
	je L_key_1
	cmp key[esi-1],' '
	je L_key_1
	inc esi
	jmp L_key
L_key_1:
	inc num_key
	mov ecx,num_key
	cmp key[esi],'-'
	je L_key2
	;����� ���
	mov dl,key[esi]
	mov new_key[ecx-1],dl
	sub new_key[ecx-1],48
	add esi,2
	cmp esi,key_len
	jge L_key_end
	cmp key[esi-1],' '
	je L_key;�ٽ� loop ���� ��
	mov al,new_key[ecx-1]
	mov bl,10
	mul bl;ax�� ���� �����
	mov new_key[ecx-1],al;�Ϲݺθ� �ʿ���
	sub key[esi-1],48;�ƽ�Ű �ڵ�
	mov dl,key[esi-1]
	add new_key[ecx-1],dl;���ڸ���
	inc esi
	cmp esi,key_len
	jge L_key_end
	cmp key[esi-1],' '; ���ڸ���
	je L_key
							; ���ڸ���
	mov al,new_key[ecx-1]
	mov bl,10
	mul bl;ax�� ���� �����
	mov new_key[ecx-1],al;�Ϲݺθ� �ʿ���
	sub key[esi-1],48;
	mov dl,key[esi-1]
	add new_key[ecx-1],dl
	inc esi
	cmp esi,key_len
	jge L_key_end
	jmp L_key

L_key2:
		mov dl,key[esi+1]
		mov new_key[ecx-1],dl
		sub new_key[ecx-1],48
		add esi,3
		neg new_key[ecx-1]
		cmp esi,key_len
		jge L_key_end
		cmp key[esi-1],' '
		je L_key;�ٽ� loop ���� ��

		mov al,new_key[ecx-1]
		mov bl,10
		mul bl;ax�� ���� �����
		mov new_key[ecx-1],al;�Ϲݺθ� �ʿ���
		sub key[esi-1],48;�ƽ�Ű �ڵ�
		mov dl,key[esi-1]
		sub new_key[ecx-1],dl
		inc esi
		cmp esi,key_len
		jge L_key_end
		cmp key[esi-1],' ';���̳ʽ� �ִ� -30 ���� ���ڸ���
		je L_key
							;���̳ʽ� �ִ� ���ڸ���
		mov al,new_key[ecx-1]
		mov bl,10
		mul bl;ax�� ���� �����
		mov new_key[ecx-1],al;�Ϲݺθ� �ʿ���
		sub key[esi-1],48;
		mov dl,key[esi-1]
		sub new_key[ecx-1],dl
		inc esi
		cmp esi,key_len
		jge L_key_end
		jmp L_key
L_key_end:
ret
getkey ENDP


main PROC
beginwhile:
		mov edx, OFFSET p_text1
		call WriteString
		mov edx, OFFSET txt
		mov ecx,SIZEOF txt-1
		call ReadString
		cmp eax,1
		jl endwhile
		cmp eax,40
		jg beginwhile
		mov txt_len, eax 
L_key:		
		mov edx, OFFSET p_text2 
		call WriteString
	
		mov edx, OFFSET key
		mov ecx,SIZEOF key-1
		call ReadString
		
		cmp eax,1
		jl L_key
		mov key_len,eax
		call Crlf
		call getkey;key�� ���ڷ� �ٲ� �迭�� ����
		mov esi,0
		mov edx, OFFSET p_text3 ;���� txt
		call WriteString
		mov edx,OFFSET txt
		call WriteString
		call Crlf
		mov ecx, txt_len
		mov esi,0
		mov edx, OFFSET p_text4 ;��ȣȭ�ϴ�
		call WriteString
		call enc;��ȣȭ�ϴ� �Լ� ȣ��
		mov edx, OFFSET txt
		call WriteString
		call Crlf
		mov ecx, txt_len
		mov esi,0
		mov edx, OFFSET p_text5
		call WriteString
		call decre
		mov edx,OFFSET txt
		call WriteString
		call Crlf
		call Crlf
		call Crlf
		jmp beginwhile
	endwhile:
		mov edx, OFFSET bye
		call WriteString

exit
main ENDP
END main