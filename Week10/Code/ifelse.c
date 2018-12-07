#include <stdio.h>
#include <stdbool.h>

int main (void)
{
    bool x = false; // single '=' is assignment

    if (x){ // double '==' is equal to
        // Code executes here
        printf("x is non-zero\n");
    }
    else{
        printf("x is zero\n");
    }

    return 0;
}