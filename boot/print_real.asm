
print_real: 
    pusha
    mov ah, 0x0e
    print_real_loop: 
        mov al, [bx]
        cmp al, 0
        je  print_real_exit
        int 0x10
        add bx, 0x01
        jmp print_real_loop
    print_real_exit: 
    popa
    ret
    
print_hex: 

    push dx
    mov  cx, 3
    mov  bx, data_hex

    print_hex_start:    
        sub cx, 1
        cmp cx, 0
        je print_hex_exit

        mov ax, dx
        shr dx, 4
        cmp dl, 0x09
        jg  print_hex_sym

        add dl, '0'
        mov [bx], dl
        mov dx, ax
        shl dx, 4
        and dx, 0xF0
        add bx, 1
        
        jmp print_hex_start
    
    print_hex_sym:
        sub dl, 0x0a
        add dl, 'a'
        mov [bx], dl
        mov dx, ax
        shl dx, 4
        and dx, 0xF0
        add bx, 1
        
        jmp print_hex_start

    print_hex_exit:

    mov bx, data_hex
    call print_real

    pop dx
    ret

data_hex: 
    db '00', 0