[BITS 16]          ; Mode réel (16-bit)
[ORG 0x7C00]       ; L'adresse où le BIOS charge le bootloader

start:
                   ; Afficher un message
    mov si, msg    ; Charger l'adresse du message
    call print     ; Appeler la fonction d'affichage

    jmp $          ; Boucle infinie (attend un redémarrage)

; Fonction d'affichage d'une chaîne de caractères
print:
    mov ah, 0x0E   ; Fonction BIOS : affichage de texte
.loop:
    lodsb          ; Charger le prochain caractère dans AL
    cmp al, 0      ; Vérifier la fin de chaîne (NULL)
    je done        ; Si terminé, retourner
    int 0x10       ; Afficher le caractère
    jmp .loop      ; Continuer la boucle
done:
    ret

msg db "Hello, OS World!", 0  ; Message terminé par NULL

; Remplir jusqu'à 512 octets (taille d'un secteur de boot)
times 510-($-$$) db 0
dw 0xAA55  ; Signature de boot (obligatoire)