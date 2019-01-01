#include <stdio.h>


int main (void)
{
    int x; // Hey OS! Give me some space for an integer called x!
    x = 0; // Initialise the variable! (or garbage returned)

    printf("The value of x: %i\n", x);

    return x; // Pass the value in x back to the calling operation, in this case the OS
}