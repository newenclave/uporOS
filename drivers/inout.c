
#include <stdint.h>

//asm ( assembler template 
//    : output operands               /* optional */
//    : input operands                /* optional */
//    : list of clobbered registers   /* optional */
//    );

uint8_t port_in_8( uint16_t port )
{
    uint8_t res;
    __asm__("in %%dx, %%al" 
            : "=a"(res) 
            : "d"(port) 
            : );
    return res;
}

void port_out_8( uint16_t port, uint8_t data )
{
    __asm__("out %%al, %%dx" 
            : 
            : "a"(data), "d"(port)
            : );
}

uint16_t port_in_16( uint16_t port )
{
    uint16_t res;
    __asm__("in %%dx, %%al" 
            : "=a"(res) 
            : "d"(port) 
            : );
    return res;
}

void port_out_16( uint16_t port, uint16_t data )
{
    __asm__("out %%al, %%dx" 
            : 
            : "a"(data), "d"(port)
            : );
}

