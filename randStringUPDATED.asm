; randString.asm - Generates 10 random strings and outputs to console

; GOAL: Generate 10 randomized strings of 10 characters, and output them to console
; SOLUTION: Use RandomRange to generate random numbers 0-25, corresponding to the alphabet. Convert this to ASCII, store the character, then repeat.
include Irvine32.inc

.data
    RANDOM_STRING_LENGTH EQU 10  ; Symbolic constant, length of the random string. Change this to get strings of different lengths.
    buffer BYTE RANDOM_STRING_LENGTH+1 DUP(0)  ; Reserve memory for string of above length, with room for null terminator. Initializes all to zero
    newline BYTE 0Dh, 0Ah, 0  ; For printing a new line after each string

.code
GenerateRandomString PROC
    pushad  ; Save registers
    mov ecx, RANDOM_STRING_LENGTH  ; Loop counter for string length
    mov edi, eax  ; EAX contains the pointer to buffer

generate_loop:
    mov eax, 26  ; Set range to 0-25
    call RandomRange  ; Get random number in EAX
    add eax, 97  ; Convert to ASCII lowercase (97-122)
    mov [edi], al  ; Store character in buffer
    inc edi  ; Move to next position
    loop generate_loop  ; Repeat until string is complete

    mov byte ptr [edi], 0  ; Null-terminate the string
    popad  ; Restore registers
    ret  ; Return from procedure
GenerateRandomString ENDP

main PROC
    call Randomize  ; Initialize randomization

    mov ecx, 10  ; Loop 10 times. Change this to get more or less strings.
string_loop:
    lea eax, buffer  ; Load address of buffer
    call GenerateRandomString  ; Generate random string
    
    ; Print the generated string
    mov edx, OFFSET buffer
    call WriteString
    
    ; Print newline
    mov edx, OFFSET newline
    call WriteString
    
    loop string_loop  ; ECX gets decremented, repeats until 0

    invoke ExitProcess, 0  ; Exit program, set breakpoint here to see end result
main ENDP

end main
