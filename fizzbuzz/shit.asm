; let's play a little bit of fizzbuzz
section .text
    global _start

;# the plan is:
;# create a loop from 1 to 15
;# call a routine _fb every time in the loop

_start:
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, bye
    mov edx, l_bye
    int 0x80 ;# finish the program

    mov eax, SYS_EXIT
    mov ebx, 0
    int 0x80

;# define some data
section .data
# simpler handling of system calls
STDOUT      equ 1
SYS_EXIT    equ 1
SYS_WRITE   equ 4

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
