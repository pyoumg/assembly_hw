TITLE encrypted

include irvine32.inc

.data
p_text1 BYTE "Enter a plain text : ",0
p_text2 BYTE "Enter a key : ",0
p_text3 BYTE "Original Text : ",0
p_text4 BYTE "Encrypted Text : ",0
p_text5 BYTE "Decrypted Text : ",0
key BYTE 20 DUP(?)
key_len DWORD 0
txt_len DWORD 0
txt BYTE 41 DUP(?)
enc BYTE 41 DUP(?)
dc BYTE 41 DUP(?)
bye BYTE "Bye!",0
n DWORD 10
.code
rem PROC
;나머지를 구하는 프로시저
;Receives: eax,ebx 
;Return: eax (eax%ebx)
L1:
	cmp eax,ebx 
	jl L3
	sub eax,ebx		;eax>=ebx
	jmp L1			;unconditional jump
L3:
	ret
rem	ENDP 



main PROC
beginwhile:
		mov edx, OFFSET p_text1
		call WriteString
		mov edx, OFFSET txt
		mov ecx,SIZEOF txt-1
		call ReadString
		cmp eax,1
		jl endwhile
	
		mov txt_len, eax 
		
		
		mov edx, OFFSET p_text2 
		call WriteString
	
		mov edx, OFFSET key
		mov ecx,SIZEOF key-1
		call ReadString
		cmp eax,1
		jl beginwhile
		mov ebx,eax
		mov ecx,txt_len
		mov key_len,ebx
		mov eax,n
		call WriteChar
		mov edx, OFFSET p_text3 ;원래 txt
		call WriteString
		mov esi, 0
	L0:
			mov al,txt[esi]
			call WriteChar
			inc esi

		loop L0
		mov eax,n
		call WriteChar
		mov edx,OFFSET p_text4
		call WriteString
		mov esi,0
		mov ecx,txt_len
	
	 L1:						;ecx(txt_len만큼)loop
		    mov dl, txt[esi]
			mov eax,esi
			call rem
			mov al,key[eax]
			
			xor dl,al
			mov al,dl
			call WriteChar
			mov enc[esi],al
		    inc esi
	    loop L1
		mov eax,n
		call WriteChar ;개행문자 
		mov ecx, txt_len
		mov esi, 0
		mov edx, OFFSET p_text5
		call WriteString
	 L2:
		mov dl,enc[esi]
		mov eax,esi
		call rem
		mov al,key[eax]
		xor al,dl
		call WriteChar
		mov dc[esi],al
		inc esi
	  loop L2
		mov eax,n
		call WriteChar
		call WriteChar
		jmp beginwhile
	endwhile:
		mov edx, OFFSET bye
		call WriteString



exit
main ENDP
END main