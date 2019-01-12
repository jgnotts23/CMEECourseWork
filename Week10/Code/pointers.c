#include <stdio.h>
#include <stdlib.h>

int main (void)
{
    int i = 0;
    int *int_ptr = NULL; /* Good practice to 
    initialise a pointer to a NULL value */

    printf("The value of i BEFORE indirection: %i\n", i);

    int_ptr = &i; //address of i has been assigned to pointer

    // Now we can assign a value to i in 1 of 2 ways:
    // i = 4; //or
    *int_ptr = 4; //dereferencing or indirection
    /* This means 'assign the value 4 to the variable
    at the address stored in int_ptr' */

    printf("The value of i AFTER indirection: %i\n", i);

    return 0;
}