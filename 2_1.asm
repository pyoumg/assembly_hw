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
;대소문자 바꾸는 프로시저
;Receives:eax
; Returns: eax,대소문자 바뀌어서 출력

	cmp eax,96			;소문자의 아스키코드가 97~122
	jg L1				;소문자면 점프
	jl L2				;대문자면 L2로 점프
L1:cmp eax,122
	jg L3
	sub eax,32
	jmp L3				;exit

L2: 
	cmp eax,65			;대문자의 아스키코드 65~90
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
		mov ecx, SIZEOF r_text-1	;뒤에 있는 0은 빼고 센다
		call ReadString
	
		mov len_text, eax 
		mov ecx, len_text
		cmp ecx,40
		jg beginwhile
		cmp ecx,1
		jl endwhile
	    mov esi, 0
	 L1:							;ecx만큼 loop를 돈다
		    mov al, r_text[esi]
			push eax
		    inc esi
	    loop L1
	 mov ecx, len_text				;ecx=문장 길이
	 mov esi, 0
	 mov edx, OFFSET p_text2
	 call WriteString
	 L2:
		    pop eax
			call Alp
			call WriteChar    
	    loop L2
		mov eax,n					;개행문자 출력
		call WriteChar
		jmp beginwhile
	endwhile:
		mov edx, OFFSET by
		call WriteString
    exit
main ENDP
END main

