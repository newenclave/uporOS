
;; boot start

[org 0x7c00]

    mov [BOOT_DRIVE], dl

    mov bp, 0x8000
    mov sp, bp

    mov  bx, hello_message
    call print_real
    
    jmp enter_protected

%include "print_real.asm"
%include "disk_load.asm"
%include "gdt.asm"
%include "protected_mode.asm"

hello_message:
    db 'Real mode start', 10, 13, 0

BOOT_DRIVE: db 0

    ;; paddings
    times 510-($-$$) db 0
    dw 0xaa55
