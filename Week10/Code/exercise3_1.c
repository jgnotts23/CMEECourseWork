#include <stdio.h>

int main (void)
{
    int x = 'x';
    int y = 1;
    int z = 0;
    int a = 0;
    float b = 3.142;
    float c = 0;
    float d = 0;
    char e = 'e';
    float f = 0;

    z = x + y;
    a = x - y;
    c = b + 2;
    d = b - 2;
    f = b + e;

    printf("\nAdding/subtracting from an arbitary character value\nThe character value of 'x' is %i\n", x);
    printf("y = %i\n", y);
    printf("Therefore:\n'x' + y = %i\n'x' - y = %i\n", z, a);
    printf("\nAdding/subtracting whole constant numbers to/from floats\nb = 3.142\nTherefore:\nb + 2 = %.3f\nb - 2 = %.3f\n", c, d);
    printf("\nAdding a character to a float:\nb + 'e' = %.3f\n", f);

    return 0;
}