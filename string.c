#include <tinyos/string.h>
#include <tinyos/inttypes.h>

void memset(void *base, uint8_t val, size_t n)
{
	char *ptr = (char *)base;
	uint32_t i;
	for (i = 0; i < n; i++)
	{
		ptr[i] = val;
	}
}
