#ifndef __TINYOS_STRING_H__
#define __TINYOS_STRING_H__

#include <tinyos/inttypes.h>

/*
 * Set a portion of memory, of length n and starting at base, to the given value
 */
void memset(void *base, uint8_t val, size_t n);

#endif
