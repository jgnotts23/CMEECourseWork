#include <stdio.h>

int main (void)
{
    int arraylen = 5;
    int intarray[5];    // Declare array and specify no. elements
    int implarray[ ] = {1, 2, 4, 5, 6, 7}; // Implicit array

    int i = 0;
    int x = 0;

    for (i = 0; i < arraylen; ++i) {
        x = intarray[i];
        printf("Value at intarray[%i] is: %i\n", i, x);
    }

    // NOTE, if you go beyond array bounds it will return garbage
    for (i = 0; i < 10; ++i) {
        x = implarray[i];
        printf("Value at implarray[%i] is: %i\n", i, x);
    }

    for (i = 0; i < 5; ++i) {
        intarray[i] = i + 1;
        printf("Value at intarray[%i] is: %i\n", i, x);
    }

    int joinedarray[arraylen + 6];

    for (i = 0; i < (arraylen + 6); ++i) {
        if (i < arraylen) {
            joinedarray[i] = intarray[i];
        }
      
        joinedarray[i + arraylen] = implarray[i];
    }   

    for (i = 0; i < (arraylen + 6); ++i) {
        printf(" %i", joinedarray[i]);
    }
    printf("\n");


    /* To add arrays you'd need to make a third array and
    then loop through and add each element in turn */

    return 0;
}