TITLE boolean Calculator
;제출할때 주석떼고 제출하기
include irvine32.inc
.data
buffer BYTE 21 DUP(0)
CaseTable BYTE '1'
		  DWORD AND_op
EntrySize=($-CaseTable)
		  BYTE '2'
		  DWORD OR_op
		  BYTE '3'
		  DWORD NOT_op
		  BYTE '4'
		  DWORD XOR_op
		  
NumberOfEntries=($-CaseTable)/EntrySize

str1 BYTE "1. x AND y",0 
str2 BYTE "2, x OR y",0
str3 BYTE "3. NOT x",0
str4 BYTE "4. X XOR y",0
str5 BYTE "5. Exit program",0
choosecal BYTE "Choose Calculation Mode : ",0
enterx BYTE "Enter x : ",0
entery BYTE "Enter y : ",0
resultxy1 BYTE "Result of x AND y : ",0
resultxy2 BYTE "Result of x OR y : ",0
resultxy3 BYTE "Result of NOT x : ",0
resultxy4 BYTE "Result of X XOR y : ",0
Bye BYTE "Bye!",0
changemode BYTE "Do you want to change the mode(Y/N)?: ",0
hexnum DWORD 16
intx DWORD 0	;32bit integer, 0이 초기값
inty DWORD 0
ans DWORD 0
ifxory DWORD 0 ;x를 구하면 0,y는 1
.code

listprint PROC ;출력해야할 리스트들을 프린트 하는 프로시저 receives, returns ; nothing
mov edx, OFFSET str1
call WriteString
call Crlf
mov edx, OFFSET str2
call WriteString
call Crlf
mov edx, OFFSET str3
call WriteString
call Crlf
mov edx, OFFSET str4
call WriteString
call Crlf
mov edx, OFFSET str5
call WriteString
call Crlf
call Crlf
call Crlf

ret
listprint ENDP


inputxy PROC
;숫자 받고 ans에 저장,올바른 값이 아니면 다시받는 프로시저
mov ans,0 ;초기화
Lx:cmp ifxory,0
	jne Ly
	mov edx, OFFSET enterx
	call WriteString
	jmp Ls
Ly:mov edx, OFFSET entery
	call WriteString
Ls:	mov edx,OFFSET buffer
	mov ecx,SIZEOF buffer
	call ReadString
	mov ecx,eax
	cmp eax,8
	jg Lx
	cmp eax,1
	jl Lx
	mov esi,0
	Lx1:
		cmp buffer[esi],'0'
		jl Lx
		cmp buffer[esi],'9'
		jl Lx2;숫자이므로 별다른 검사를 하지 않는다.
		cmp buffer[esi],'A'
		jl Lx
		cmp buffer[esi],'F'
		jle Lx2; 대문자
		cmp buffer[esi],'a'
		jl Lx
		cmp buffer[esi],'f'
		jg Lx
		;여기까지 오면 소문자
	Lx2:
		inc esi
		loop Lx1
		;여기까지 오면 해당 문자열은 16진수에 해당한다.
	mov ecx,eax
	mov esi,1
	Lx3:;해당 문자열을 intx에 저장해야한다.
		movzx eax,buffer[ecx-1]
		cmp eax,58
		jl Lx3_1
		cmp eax,71
		jl Lx3_2
		sub eax,87;대문자라서
		jmp Lx3_4
	Lx3_2:sub eax,55;소문자
		jmp Lx3_4
	Lx3_1:sub eax,48;숫자
	Lx3_4:mul esi;곱이 eax에 저장된다
		mov ebx,eax
		mov eax,esi
		mul hexnum
		mov esi,eax;곱의 하반부가 eax에 저장됨, 상반부는 무시해도 됨
		add ans,ebx;intx에 bx가 더해진다
	loop Lx3
	mov eax,ans

ret
inputxy ENDP

AND_op PROC;and 계산
	mov ifxory,0
	call inputxy
	mov eax,ans
	mov intx,eax
	mov ifxory,1
	call inputxy
	mov eax,ans
	and eax,intx ;값이 eax에 저장
	mov edx, OFFSET resultxy1
	call WriteString
	call WriteHex;계산값 출력
	call Crlf
	call Crlf
	call Crlf
ret
AND_op ENDP

OR_op PROC;or계산
	mov ifxory,0
	call inputxy
	mov eax,ans
	mov intx,eax
	mov ifxory,1
	call inputxy
	mov eax,ans
	or eax,intx ;값이 eax에 저장
	mov edx, OFFSET resultxy2
	call WriteString
	call WriteHex;계산값 출력
	call Crlf
	call Crlf
	call Crlf
ret
OR_op ENDP

NOT_op PROC;not  계산
	mov ifxory,0
	call inputxy
	mov eax,ans
	not eax
	mov edx, OFFSET resultxy3
	call WriteString
	call WriteHex
	call Crlf
	call Crlf
	call Crlf
ret
NOT_op ENDP

XOR_op PROC
	mov ifxory,0
	call inputxy
	mov eax,ans
	mov intx,eax
	mov ifxory,1
	call inputxy
	mov eax,ans
	xor eax,intx ;값이 eax에 저장
	mov edx, OFFSET resultxy4
	call WriteString
	call WriteHex
	call Crlf
	call Crlf
	call Crlf
ret
XOR_op ENDP

main PROC
beginwhile:
	call listprint
read_mode:
	mov edx, OFFSET choosecal
	call WriteString
	call ReadChar	;eax에 값이 들어감
	call WriteChar
	call Crlf
	mov ebx,OFFSET CaseTable
	mov ecx, NumberOfEntries
L1:
	cmp al,[ebx]
	jne L2
L1_1:push ebx
	call NEAR PTR [ebx+1]
	pop ebx
	jmp aftercal
	
L2:
add ebx,EntrySize
	loop L1
L3:
	cmp al,'5'
	je endwhile
	jmp read_mode;1~5가 아니므로 다시 읽는다.

aftercal:;계산 이후에 모드를 바꿀지 물어봄
	mov edx, OFFSET changemode
	call WriteString
	call ReadChar
	call WriteChar
	call Crlf
	call Crlf
	call Crlf
	cmp al,'Y'
	je beginwhile
	cmp al,'N'
	je L1_1
	jmp aftercal
endwhile:
	call Crlf
	call Crlf
	mov edx,OFFSET Bye
	call WriteString

exit
main ENDP
END main
