#include <stdio.h>
#include <stdlib.h>

int main (void)
{
    const int NUM = 5; // standard practice to capitalise constant variable names but not mandatory
    printf("%d\n", NUM);
    // NUM = 8; cannot modify as num has been made a constant
    printf("%d\n", NUM);

    printf("Hello\n"); //"Hello" also considered a constant
    printf("%d\n", 70); // 70 is also a constant here

    return 0;
}