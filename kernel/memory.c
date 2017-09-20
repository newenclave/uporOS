#include "memory.h"

void *k_memcpy(void *src, void *dst, unsigned int count)
{
    char *srcc = src;
    char *dstc = dst;
    for( unsigned int i = 0; i<count; ++i ) {
        dstc[i] = srcc[i];
    }
    return dst;
}

void *k_memset( void *src, int c, unsigned int count )
{
    char *srcc = src;
    for( unsigned int i=0; i<count; ++i ) {
        *srcc++ = c;
    }
    return src;
}
