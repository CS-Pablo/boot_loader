[BITS 16]
[ORG 0x7C00]

start:
    cli                     ; Désactiver les interruptions
    lgdt [gdt_descriptor]    ; Charger la GDT
    mov eax, cr0
    or eax, 1
    mov cr0, eax            ; Activer le mode protégé
    jmp CODE_SEG:init_pm    ; Sauter en mode protégé

; ---------------- Mode protégé ----------------
[BITS 32]
init_pm:
    mov ax, DATA_SEG
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    mov esp, 0x90000        ; Initialiser la pile
    call kernel_main        ; Appeler le kernel (chargé en mémoire)

hang:
    jmp hang                ; Boucle infinie

; ---------------- GDT (Global Descriptor Table) ----------------
gdt_start:
    dq 0                    ; Null descriptor
gdt_code:
    dw 0xFFFF, 0x0000, 0x9A00, 0x00CF  ; Code segment (exécutable)
gdt_data:
    dw 0xFFFF, 0x0000, 0x9200, 0x00CF  ; Data segment (lecture/écriture)
gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1  ; Taille de la GDT
    dd gdt_start                ; Adresse de la GDT

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start

times 510-($-$$) db 0
dw 0xAA55