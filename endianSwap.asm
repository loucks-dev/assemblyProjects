include Irvine32.inc
.data

bigEndian BYTE 12h,34h,56h,78h ; This will be stored in memory as 12345678h
littleEndian DWORD? ; Need to convert bigEndian above to be 78563412h in memory

.code
main proc
;GOAL: Convert bigEndian to littleEndian
;SOLUTION: Move each byte of bigEndian to littleEndian in reverse order using smaller registers

    mov al, BYTE PTR bigEndian[0] ; Move first byte 
    mov BYTE PTR littleEndian[3], al 

    mov al, BYTE PTR bigEndian[1] ; Move second byte 
    mov BYTE PTR littleEndian[2], al 

    mov al, BYTE PTR bigEndian[2] ; Move third byte
    mov BYTE PTR littleEndian[1], al 

    mov al, BYTE PTR bigEndian[3] ; Move fourth byte
    mov BYTE PTR littleEndian[0], al 
int 3;
    invoke ExitProcess,0 ; Exit program, use this line as a breakpoint for the debugger
main endp
end main
