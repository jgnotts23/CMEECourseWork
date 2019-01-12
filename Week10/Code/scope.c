#include <stdio.h>

int main (void)
{
    int i = 5; // Global variable
    
    printf("i in scope of main(): %i\n", i);

    {
        int i = 10; // local variable, i = 10 only here
        printf("i in local scope: %i\n", i);
    }

    if (i) { // Still uses global i
        printf("This i is %i\n", i);
    }

    if (i) {
        int i = 50; // i redefined within the scope of this if statement
        printf("A new automatic i: %i\n", i);
    }

    return 0;
}