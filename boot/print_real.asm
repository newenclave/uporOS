
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
    