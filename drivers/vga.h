
//#include <stdint.h>

#define VIDEO_MEMORY_ADDRESS 0xb8000
#define MAX_ROWS 25
#define MAX_COLS 80

// Attribute byte for our default colour scheme.
#define WHITE_ON_BLACK 0x0F

// Screen device I/O ports
#define REG_SCREEN_CTRL 0x3D4
#define REG_SCREEN_DATA 0x3D5

void print_char(char c, int col, int raw, char attr);
void print(char *message);
void clear_screen( );
void scroll( );
