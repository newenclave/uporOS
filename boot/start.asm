
;; boot start

[bits 16]
[org 0x7c00]

    mov bp, 0x8000
    mov sp, bp

    mov bx, hello_message
    call print_real

    jmp enter_protected

hello_message:
    db 'Real mode start', 10, 13, 0

%include "print_real.asm"
%include "gdt.asm"
%include "protected_mode.asm"

    ;; paddings
    times 510-($-$$) db 0
    dw 0xaa55
