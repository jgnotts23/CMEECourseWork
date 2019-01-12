#include <stdio.h>
#include <stdbool.h>

// Illustration of how bolean data evaluates
int main (void)
{
    bool realitycheck = false;
    bool realitycheck2 = true;

    printf("Boolean evaluation:\nfalse = %d, true = %d\n", realitycheck, realitycheck2);

    int a = 2;
    int b = 1;
    printf("\n'Less than' and 'Greater than' operators:\na = %i, b = %i\n", a, b);
    printf("a < b = false = %d\n", a < b); //evaluates to false (zero)
    printf("a > b = true = %d\n", a > b); //evaluates to true (non-zero)
    printf("\n'Equal to' and 'Not equal to' operators:\na == b: false = %d\n", a == b); //evaluates to false (zero)
    printf("a != b: true = %d\n", a != b); //evaluates to true (non-zero)

    int c = 0;
    printf("\nThe unary negation ('not') operator:\nc = 0, Therefore: !c = true = %d\na != b, can be written as: !(a == b)\n!(a != b), can be written as: a == b\n", !c);

    int d = 12;
    int e = 12;
    printf("\nThe logical 'and' operator, &&:\nif d = 12 and e = 12\nthen (d && d==e) = %d\nBoth operands must be true (non-zero) for 1 to be returned\n", d && d==e);

    printf("\nThe logical 'or' operator, ||:\nif d = 12 and b = 1\nthen (d || d==b) = %d\nOnly one operand must be true (non-zero) for 1 to be returned\n", d || d==b);

    return 0;
}