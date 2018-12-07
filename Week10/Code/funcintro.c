#include <stdio.h>

int add_integers(int a, int b)
{
    int result = 0;

    result = a + b;

    return result;
}


int main (void)
{

    int result = 0;
    int a = 4;

    result = add_integers(a, 2);

    printf("Result: %i\n", result);    

    return 0;
}