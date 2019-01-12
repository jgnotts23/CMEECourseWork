#include <stdio.h>
#include <stdbool.h>

int main (void)
{
    // The while loop
    int i = 0;

    while (i < 10) {
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

    // The break keyword
    // i = 0;
    // while () {
    //     if (i == 0) {
    //         break; //terminates loop whether while conditions have been met or not
    //     }
    //     ++i;
    // }

    // The continue statement
    i = 0;
    for (i = 1; i < 10; ++i) {
        if (i % 2) {
            printf("%i is an odd number\n", i);
            continue;
        }

        printf("%i is an even number\n", i);
    }

    return(0);
}