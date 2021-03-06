
disk_load:
    push dx

    mov ah, 0x02
    mov al, dh
    mov ch, 0x00
    mov dh, 0x00
    mov cl, 0x02

    int 0x13
    jc  disk_error_check

    pop dx
    ;cmp dh, al
    ;jne disk_error_2
    ret

disk_error_check:
    cmp ah, 0x00
    jne disk_error_msg
    ret


disk_error_msg:
    mov  bx, DISK_ERROR_MSG
    call print_real
    mov  dl, ah
    call print_hex
    jmp $

disk_error_2:
    mov bx, DISK_ERROR_MSG2
    call print_real
    jmp $

DISK_ERROR_MSG  db "Disk read error: ", 0
DISK_ERROR_MSG2 db "Invalid size.", 10, 13, 0
