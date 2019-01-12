#include <stdio.h>

int main (void)
{
    int a = 7;
    int b = 2;
    float c = 0;

    c = (float) a / b; /* This is the cast operator.
    It tells the compiler to treat operands or expression 
    results as a different type of data. Here we are 
    interpreting a float value as an integer.
    The cast operator has higher precedence than the
    / operator so a and b are converted to float */

    printf("%i / %i = %f\n", a, b, c);

    return 0;
}