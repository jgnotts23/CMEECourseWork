#include <stdio.h>

int main (void)
{
    int a = 7;
    float b = 2;
    float c = 0;

    c = a / b; // Will do integer division

    printf("The results of %i divided by %f is: %f.\n", a, b, c);

    return 0;
}