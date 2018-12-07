#include <stdio.h>
#include <stdbool.h>

int main (void)
{
    // The while loop
    int i = 0;

    while (i < 10 && i != 0) {
        printf("loop iteration: %i\n", i);
        ++i;   // increment i
    }

    // Do-while
    i = 0;
    do {            // Can use do loop, doesn't need condition to be met to start
        printf("do-while loop iteration: %i\n", i);
        ++i;  
    } while (i < 10 && i != 0);

    // For loop
    // Starting val; condition; function
    for (i = 0 ; i < 10 ; ++i) {
        printf("for loop iteration %i\n", i);
    }

    return(0);
}