#include <stdio.h>

int main (void)
{
    /* 
    x = x + 1; increment operator
    x = x - 1; de-increment operator
    ++x increment abbreviation
    x++ alternative abbreviation
    --x de-increment abbreviation
    x-- alternative abbreviation

    However, using the prefix or postfix operator it
    determines the order in which the assignment and 
    increment/deincrement are performed 
    */

    int a = 3;
    int b = 0;
    printf("a = %i, b = %i\n", a, b);

    b = a++; // a is assigned to b THEN a is incremented
    printf("Using postfix operator: b = a++ = %i. a now equals %i\n", b, a);

    a = 3;
    b = 0;
    printf("\na = %i, b = %i\n", a, b);

    b = ++a; // a is incremented THEN assigned to b
    printf("Using prefix operator: b = ++a = %i. a now equals %i\n", b, a);

    return 0;
}