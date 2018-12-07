#include <stdio.h>

int main (void)
{
    int x = 1000000000; //Max integer length 
    float y = 3.14159265358979323846264338327950288419;
    char z = 'z';
    long double a = 3.14159265358979323846264338327950288419;

    printf("The value of x: %i\n", x);
    printf("The value of y: %f\n", y);
    printf("The value of z: %c\n", z);
    printf("The value of a: %.40Lf\n", a);

    return x;
}