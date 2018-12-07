#include <stdio.h>

// Can use global variables here but not advised

int main (void)
{
    int x; // Must declare the variable
    x=0; // Assign a value
    int y = 1; // Can be done in one line
    int z = 2;
    // Different data types require different memory

    int an_1_Integer; // Can use alphanumeric chars but cannot lead with a number
    int _AnInteger;

    char ch;
    float flt;
    double dbl;
    _Bool yesno;

    printf("The value of x: %i\n", x);

    return 0;
}