#include <stdio.h>

int main (void)
{
    char a = 'a';
    int b = 0;

    b = (int) a; //interprets 'a' as an integer, 97

    printf("b equals %i\n", b);

    return 0;
}