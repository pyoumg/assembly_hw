INCLUDE irvine32.inc 


.data
    p_text BYTE "Type_A_String_To_Reverse:",0
	p_text2 BYTE "Reversed_String:",0
	
    r_text BYTE 50 DUP(?)
	by BYTE "Bye!",0
    len_text DWORD 0  
	n DWORD 10
.code

Alp PROC
;��ҹ��� �ٲٴ� ���ν���
;Receives:eax
; Returns: eax,��ҹ��� �ٲ� ���

	cmp eax,96			;�ҹ����� �ƽ�Ű�ڵ尡 97~122
	jg L1				;�ҹ��ڸ� ����
	jl L2				;�빮�ڸ� L2�� ����
L1:cmp eax,122
	jg L3
	sub eax,32
	jmp L3				;exit

L2: 
	cmp eax,65			;�빮���� �ƽ�Ű�ڵ� 65~90
	jl L3
	cmp eax,90
	jg L3
	add eax,32
L3:
	ret
Alp ENDP



main PROC
 
    
	beginwhile:
		mov edx, OFFSET p_text
		call WriteString
		mov edx, OFFSET r_text
		mov ecx, SIZEOF r_text-1	;�ڿ� �ִ� 0�� ���� ����
		call ReadString
	
		mov len_text, eax 
		mov ecx, len_text
		cmp ecx,40
		jg beginwhile
		cmp ecx,1
		jl endwhile
	    mov esi, 0
	 L1:							;ecx��ŭ loop�� ����
		    mov al, r_text[esi]
			push eax
		    inc esi
	    loop L1
	 mov ecx, len_text				;ecx=���� ����
	 mov esi, 0
	 mov edx, OFFSET p_text2
	 call WriteString
	 L2:
		    pop eax
			call Alp
			call WriteChar    
	    loop L2
		mov eax,n					;���๮�� ���
		call WriteChar
		jmp beginwhile
	endwhile:
		mov edx, OFFSET by
		call WriteString
    exit
main ENDP
END main

