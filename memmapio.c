#include "init.h"
#include "encoding.h"

#define MU500_BASE         0x04000004

int main()
{
    *((volatile unsigned char *)MU500_BASE) = 10;
    while(1);
}
