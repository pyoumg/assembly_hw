INCLUDE irvine32.inc

.data

INCLUDE hw1_1.inc

.code
main PROC

mov eax,val1
add eax,val2
add eax,eax ;2
add eax,eax ;4
mov ebx,eax;4 4
add eax,eax;8
add eax,ebx;12

mov ebx,val2
add ebx,ebx ;2
mov ecx,ebx;2
add ebx,ebx ;4
add ecx,ebx ;6
add ebx,ebx ;8
add ebx,ebx ;16
add ebx,ebx ;32
add ebx,ecx ;38
add ebx,val2 ;39 (+12)
add eax,ebx 

mov ecx,val3
sub ecx,val4 ; val3-val4
mov ebx,ecx ;1
add ebx,ebx ;2
add ebx,ebx ;
add ebx,ecx ;4
add eax,ebx ;
call DumpRegs

add ebx,ebx ;10
add ebx,ebx ;20
sub eax,ebx
add eax,val1
add eax,val1 
mov ebx,val2
add ebx,ebx ;2
add ebx,ebx	;4
mov ecx,ebx ;4
add ebx,ebx ;8
add ebx,ebx;16
add ebx,ebx;32
add ebx,ecx ;36
add ebx,val2
add ebx,val2;38
sub eax,ebx

call DumpRegs

mov eax,val1
add eax,val2
add eax,val3
mov ebx,eax ;1
add ebx,eax ;2
add eax,ebx;3
mov ebx,val1
add ebx,ebx;2
add ebx,ebx;4
mov ecx,ebx ;4
add ebx,ebx;8
add ebx,ebx;16
add ebx,ecx;20
sub eax,ebx
mov ebx,val4
add ebx,ebx ;2
add ebx,val4 ;3
add ebx,val2
sub eax,ebx
call DumpRegs
exit
main ENDP
END main
