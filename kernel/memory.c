#include "memory.h"

void *memcopy(void *src, void *dst, unsigned int count)
{
    char *srcc = src;
    char *dstc = dst;
    for(unsigned i=0; i<count; ++i) {
        dstc[i] = srcc[i];
    }
    return dst;
}

void *mem_set(void *src, int c, unsigned int count)
{
    char *srcc = src;
    for( unsigned int i=0; i<count; ++i) {
        *srcc = (c & 0xFF);
    }
    return src; 
}
