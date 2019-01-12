#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
#include <float.h>

int main (void) 
{
    printf("Number of bits in a char: %zu\n", sizeof(char) * CHAR_BIT);
    printf("Number of bits in a int: %zu\n", sizeof(int) * CHAR_BIT);
    printf("Number of bits in a float: %zu\n", sizeof(float) * CHAR_BIT);
    printf("Number of bits in a double: %zu\n", sizeof(double) * CHAR_BIT);
    printf("Number of bits in a long double: %zu\n", sizeof(long double) * CHAR_BIT);

    return 0;
}