
#include <stdint.h>

#include "vga.h"
#include "inout.h"

static
int calc_cursor_offset( int col, int row )
{
    return (row * MAX_COLS + col) * 2;
}

int get_cursor_pos( )
{
    int res;
    port_out_8(REG_SCREEN_CTRL, 14);
    res  = (port_in_8(REG_SCREEN_DATA) << 8);

    port_out_8(REG_SCREEN_CTRL, 15);
    res += port_in_8(REG_SCREEN_DATA);

    return res * 2;
}

void set_cursor( int offset )
{
    offset /= 2;
    port_out_8(REG_SCREEN_CTRL, 14);
    port_out_8(REG_SCREEN_DATA, (uint8_t)(offset >> 8));
    port_out_8(REG_SCREEN_CTRL, 15);
    port_out_8(REG_SCREEN_DATA, (uint8_t)(offset & 0xff));
}

void set_cursor_pos( uint8_t col, uint8_t raw )
{
    int offset = calc_cursor_offset( col, raw );
    set_cursor(offset);
}

void print_char(char c, int col, int raw, char attr)
{
    char *video_mem = (char *)VIDEO_MEMORY_ADDRESS;
    int offset;
    if(attr == 0) {
        attr = WHITE_ON_BLACK;        
    }

    if(col >= 0 && raw >= 0) {
        offset = calc_cursor_offset(raw, col);
    } else {
        offset = get_cursor_pos( ); 
    }
    video_mem[offset] = c;
    video_mem[offset + 1] = attr;
    set_cursor(offset + 2);
}

void clear_screen( )
{
    unsigned char *video_mem = (unsigned char *)VIDEO_MEMORY_ADDRESS;
    for(int i = 0; i<80*25*2; i+=2) {
        video_mem[i] = ' ';
        video_mem[i] = 0;
    }
    set_cursor(0);
}

void print(char *message)
{
    unsigned char *video_mem = (unsigned char *)VIDEO_MEMORY_ADDRESS;
    while(*message) {
        print_char(*message++, -1, -1, WHITE_ON_BLACK);
    }
}

