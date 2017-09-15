
;; boot start

[org 0x7c00]
KERNEL_OFFSET equ 0x1000

    mov [BOOT_DRIVE], dl

    mov bp, 0x8000
    mov sp, bp

    ;; mov dl, 0x63
    ;; call print_hex
    ;; jmp $

    mov  bx, hello_message
    call print_real
    call load_kernel
    jmp enter_protected

load_kernel:
    mov bx, MESSAGE_LOAD_KERNEL
    call print_real
    mov  bx, KERNEL_OFFSET
    mov  dh, 2
    mov  dl, [BOOT_DRIVE]
    call disk_load
    ret

%include "print_real.asm"
%include "disk_load.asm"
%include "gdt.asm"
%include "protected_mode.asm"

hello_message:
    db 'Real mode start', 10, 13, 0
MESSAGE_LOAD_KERNEL db 'Loading kernel...', 10, 13, 0

BOOT_DRIVE: db 0

    ;; paddings
    times 510-($-$$) db 0
    dw 0xaa55
