section .text
    global _start

_start:             ;entry point
    mov eax, 1      ;i
.loop:              ;for loop
    cmp eax, 0xA    ;if i == 10
    je .end         ;break
    
    call printchar  ;print i
    
    push eax        ;backup i
    mov ecx, 3      ;divide by 3
    mov edx, 0      ;mod
    div ecx         ;do the division
    cmp edx, 0      ;if the mod operation returned 0
    pop eax         ;restore i
    jne .notfizz    ;skip fizz print
    push eax        ;backup i
    call printfizz  ;do print
    pop eax         ;restore i
    
.notfizz:
    push eax        ;backup i
    mov ecx, 5      ;divide by 5
    mov edx, 0      ;mod
    div ecx         ;do the division
    cmp edx, 0      ;if the mod operation returned 0
    pop eax         ;restore i
    jne .notbuzz    ;skip buzz print
    push eax        ;backup i
    call printbuzz  ;do print
    pop eax         ;restore i
    
.notbuzz:
    add eax, 1      ;itterate eax
    jmp .loop       ;go back to start of loop
    
.end:
    mov eax, 1      ;sys_exit
    int 0x80        ;syscasll
    
printfizz:          ;function to print fizz string from .data
    mov edx, lenfizz ;string length
    mov ecx, fizz   ;string
    mov ebx, 1      ;stdout
    mov eax, 4      ;sys_write
    int 0x80        ;syscall
    ret             ;return
    
printbuzz:          ;function to print buzz string from .data
    mov edx, lenbuzz ;string length
    mov ecx, buzz   ;string
    mov ebx, 1      ;stdout
    mov eax, 4      ;sys_write
    int 0x80        ;syscall
    ret             ;return
    
printchar:          ;prints a char in eax
    add eax, 0x30   ;convert eax int to char (only 0-9)
    push eax        ;push the char onto the stack
    mov edx, 1      ;one char
    mov ecx, esp    ;message to write
    mov ebx, 1      ;stdout
    mov eax, 4      ;sys_write
    int 0x80        ;syscall
    pop eax         ;restore old eax value
    sub eax, 0x30   ;convert back to an int from the char
    ret

section .data
    fizz db 'fizz'
    lenfizz equ $ - fizz
    buzz db 'buzz'
    lenbuzz equ $ - buzz
