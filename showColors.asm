; showColors.asm - Shows all 256 combinations of foreground and background color

; GOAL: Display a single character in all possible combinations of foreground and background colors (16x16 = 256).
; SOLUTION: Use SetTextColor and WriteChar functions within a nested loop.

INCLUDE Irvine32.inc

.data
    char BYTE "P"  ; Character to display

.code
main PROC
    mov  dh, 0           ; Set row to 0
    mov  dl, 0           ; Set column to 0
    mov  ecx, 16         ; Outer loop for background colors

outerLoop:
    push ecx             ; Save outer loop counter
    mov  ecx, 16         ; Inner loop for foreground colors

innerLoop:
    push ecx             ; Save inner loop counter
    xor  eax, eax        ; Clear EAX
    mov  al, cl          ; Foreground color (lower 4 bits)
    shl  al, 4           ; Shift to background position
    or   al, ch          ; Combine with background color
    call SetTextColor    ; Set text color

    mov  al, char        ; Load character to AL
    call WriteChar       ; Display character

    inc  dl             ; Move to next column
    cmp  dl, 16         ; Check if end of row
    jne  skipNewLine
    mov  dl, 0          ; Reset column
    inc  dh             ; Move to next row

skipNewLine: ; This loop is used to move our rows/columns for foreground/background back to the beginning
    pop  ecx            ; Restore inner loop counter
    loop innerLoop

    pop  ecx            ; Restore outer loop counter
    loop outerLoop


    exit
main ENDP

END main