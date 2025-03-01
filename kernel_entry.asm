[BITS 32]
[GLOBAL kernel_main]

kernel_main:
    mov esi, msg
    call print
    hlt                      

print:
    mov ah, 0x0E
.loop:
    lodsb
    cmp al, 0
    je done
    int 0x10
    jmp .loop
done:
    ret

msg db "Kernel loaded!", 0
