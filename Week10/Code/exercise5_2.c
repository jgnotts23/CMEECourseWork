#include <stdio.h>

int main (void) 
{
    int array1[] = {1, 2, 3, 4, 5, 6};
    int array2[] = {7, 8, 9};
    int array3[10];
    int i = 0;
    int j = 0;

    for (i = 0; i < 6; ++i) {
        array3[i] = array1[i];
    }

    for (j = 0; j < 3; ++j) {
        array3[j+6] = array2[j];
    }

    for(i = 0; i < 9; ++i) {
        printf("%d \n", array3[i]);
        //printf("\n");
    }

    return 0;
}