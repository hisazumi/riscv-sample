#include "init.h"
#include "encoding.h"

#define MU500        ((volatile unsigned char *)0x04000000)

int main()
{
    // 7seg test
    MU500[0] = 0xff;
    MU500[1] = 0x00;
    MU500[2] = 0x06;
    MU500[3] = 0x5b;
    MU500[4] = 0x4f;
    MU500[5] = 0x66;
    MU500[6] = 0x6d;
    MU500[7] = 0xfc;
    MU500[8] = 0x55;
    MU500[0x3f] = 0x55;

    // led test
    MU500[0x40] = 0xaa;
    MU500[0x41] = 0x55;
    MU500[0x42] = 0x00;
    MU500[0x43] = 0xff;
    MU500[0x44] = 0xf0;
    MU500[0x45] = 0x0f;
    MU500[0x46] = 0x0f;
    MU500[0x47] = 0x0f;

    while (1);
}
