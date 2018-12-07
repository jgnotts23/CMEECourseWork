#include <stdio.h>

int main (void)
{
    int x = 0;

    x = x + 1;
    ++x;
    --x;
    //x++;

    printf("The value of x is: %i\n", x);

    return 0;
}