INCLUDE irvine32.inc

.data

INCLUDE hw1_2.inc

.code
main PROC
mov eax,0
movzx ebx,[var1]
sub ebx,'0'
mov ecx,ebx ;1
add ebx,ebx ;2
add ebx,ebx ;4
add ebx,ebx ;8
sub ebx,ecx;7
mov ecx,ebx;ecx=7
add ebx,ebx ;14
add ebx,ebx ;28
add ebx,ebx;56
add ebx,ebx;112
mov edx,ebx;edx=112
add ebx,ebx;224
add ebx,edx;336
add ebx,ecx ;343
mov eax,ebx

movzx ebx,[var1+1]
sub ebx,'0'
mov edx,ebx
add ebx,ebx;2
add ebx,ebx;4
add ebx,ebx;8
add ebx,ebx;16
mov ecx,ebx
add ebx,ebx;32
add ebx,ecx ;48
add ebx,edx ;49
add eax,ebx

movzx ebx,[var1+2]
sub ebx,'0'
mov ecx,ebx
add ebx,ebx
add ebx,ebx
add ebx,ebx
sub ebx,ecx
add eax,ebx

movzx ebx,[var1+3]
sub ebx,'0'
add eax,ebx
call DumpRegs

exit
main ENDP
END main
