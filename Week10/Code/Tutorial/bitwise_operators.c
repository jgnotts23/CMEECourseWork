#include <stdio.h>
#include <stdlib.h>

/*  &   AND: adds together if both bits are the same (essentially only 1 + 1 returns 1, 7 & 4 = 4)
    |   OR: if either bit is 1 it returns 1 (7 | 4 = 7)
    ~   NOT: one operand, inverts bit-by-bit (~7 = 8) 
    <<  Left shift: 
    >>  Right shift:
    ^   XOR:    
*/


int main (void)
{
    char x = 1;
    char y = 2;

    /*  Bitwise 1&2:
        1(0000 0001)
        2(0000 0010)
        & ---- ----
        0(0000 0000)
    */

    if (x&y) {          // This is not satisfied as 1&2 = 0 = FALSE
        printf("x & y = 1\n");
    }
    
    if (x&&y) {         // This is satisfied as 1&&2 = TRUE && TRUE = TRUE = 1
        printf("x && y = 1\n");
    }

    /* Left shift operator:
    First operand(whose bits get shifted) << Second operand(No. of places to shift the bits) 
        - When bits are shifted left, trailing positions are filled with zeros */

    char var = 3; // 3 in binary = 0000 0011
    // 3 << 1 = 0000 0110 = 6
    printf("3 << 1 = %d\n", var << 1);

    /* Left shifting is equivalent to multiplication by 2^(rightoperand)
    e.g. 3 x 2^1 = 6 as found above */

    /* Right shift operator:
    First operand(whose bits get) >> Second operand (No. of places to shift bits)
        - When bits are shifted right, leading positions are filled with zeros */

    printf("3 >> 1 = %d\n", var >> 1);

    /* Right shifting is equivalent to integer division by 2^(rightoperand)
    e.g. 3 / 2 = 1.5 = 1(no decimals) */

    return 0;
}