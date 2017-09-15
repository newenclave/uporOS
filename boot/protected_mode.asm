
VIDEO_MEMORY equ 0xb8000
WHITE_BLACK  equ 0x0F
GREEN_BLACK  equ 0x0A

[bits 16]

enter_protected:
    cli
    lgdt [gdt_descriptor]
    mov eax, cr0
    or  eax, 0x01
    mov cr0, eax
    jmp CODE_SEG:init_protected

[bits 32]

init_protected:
    mov ax, DATA_SEG
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x90000
    mov esp, ebp

    call clear_screen
    mov  ebx, message
    call print_message

    jmp start_protected_mode

print_message:
    pusha
    mov edx, VIDEO_MEMORY

    print_message_loop:
        mov al, [ebx]
        mov ah, GREEN_BLACK
        cmp al, 0
        je  print_message_exit
        mov [edx], ax
        add ebx, 1
        add edx, 2
        jmp print_message_loop
    print_message_exit:
    popa 
    ret

clear_screen:

    pusha
    mov edx, VIDEO_MEMORY
    mov ecx, 80 * 25
    mov ax,  32    

    clear_screen_loop:
        mov [edx], ax
        sub ecx, 1
        cmp ecx, 0
        je  clear_screen_exit
        add edx, 2
        jmp clear_screen_loop
    clear_screen_exit:
    popa   
    ret

start_protected_mode:
    jmp $

message:
    db 'uporOS has just entered protected mode!', 0
