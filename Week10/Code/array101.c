#include <stdio.h>

int main (void)
{
    // Two methods for initialising an array
    int myarray[5]; // 5 is the size parameter, space for 5 integers
    int myarray2[] = {1, 2, 3, 4, 5};

    // To initialise an array to all-zero values:
    int myarray3[5] = {0};

    // Array indexing
    myarray[0] = 10; // Same indexing as python

    // To obtain a value
    printf("The value at index %i in my array: %i\n", 0, myarray[0]);

    // Alternatively, we could use it in an assignment
    int i = 0;
    int element = 0;
    int myarray4[] = {1, 2, 3, 4, 5};

    element = myarray4[i];

    printf("The value at index %i in my array : %i\n", i, element);

    // Using arrays in arithmetic calculations
    int result;
    int myarray5[] = {1, 2, 3, 4, 5};

    result = myarray5[1] + myarray5[1];
    printf("result = %i\n", result);

    myarray5[0] = myarray5[1] + myarray5[1];
    printf("myarray5[0] = %i\n", 0, myarray5[0]); //doesn't work

    // Variable-size arrays
    int n_entries = 10;

    int myarray[n_entries]; // later in the program
    // These are much safer


    return 0;
}