# simpler handling of system calls
STDOUT      equ 1
SYS_EXIT    equ 1
SYS_WRITE   equ 4


; a macro for printing
%macro print_string 2
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, %1
    mov edx, %2
    int 0x80
%endmacro

%macro check_division 2
    mov dx, 0
    mov ax, %1
    mov bx, %2
    div bx  ; modulo is stored in dx
%endmacro

; let's play a little bit of fizzbuzz
section .text
    global _start

;# the plan is:
;# create a loop from 1 to 15
;# call a routine _fb every time in the loop

_start:
    mov ecx, 1

l1:
    ; print out the number itself
    push ecx
    call _fb
    pop ecx
    inc ecx
    cmp ecx, 20
    jl  l1
    jmp _exit

_fb:
    check_division cx, 3
    cmp dx, 0
    jne check5
    push ecx
;    mov [num], cx
    print_string fizz, l_fizz
    pop ecx
;    mov ecx, [num]
;    sub ecx, '0'
;    ret

check5:
    check_division cx, 5
    cmp dx, 0
    jne _newline
    push ecx
    print_string buzz, l_buzz
    pop ecx

_newline:
    push ecx
    print_string newline, l_newline
    pop ecx
    ret

_exit:
    ; say bye
    print_string bye, l_bye
    ; finish the program
    mov eax, SYS_EXIT
    mov ebx, 0
    int 0x80


;# define some data
section .data
newline db 0xA, 0xD
l_newline equ $ - newline

;# fizz message
fizz db 'Fizz'
l_fizz equ $ - fizz

;# buzz message
buzz db 'Buzz'
l_buzz equ $ - buzz

;# bye message
bye db 'Bye', 0xA, 0xD
l_bye equ $ - bye

section .bss
; let's keep some space for our numbers
num resb 2
