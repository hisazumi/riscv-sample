#include "init.h"
#include "encoding.h"

#define MU500        ((volatile unsigned char *)0x04000000)

int main()
{
    int a = 0;
    MU500[0] = 0xff;
    while (1) {
        MU500[1] = MU500[0x48];
    }
    return 0;
}
