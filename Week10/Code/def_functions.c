#include <stdio.h>

long double divide_ints(long long int num, long long int denom)
{

    long double result = 0.0;

    result = (long double)num / (long double)denom;
    //Typecast inputs to long doubles

    return result;
}

int add_integers(int a, int b) // function declaration
    {
        return a + b;
    }

int main (void)
{
    int a = 1;
    int b = 1;
    int result = 0;

    result = add_integers(a, b); // function call
    printf("%i + %i = %i\n", a, b, result);

    long long d = 2019128293; //long long is analagous to long long int
    long long e = 5758734999;
    long double f;

    f = divide_ints(d, e);
    printf("c = %Lf\n", f);

    return 0;
}