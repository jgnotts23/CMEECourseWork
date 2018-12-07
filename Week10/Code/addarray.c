#include <stdio.h>

void concat_array(int result[], int reslength, int array1[], int array2[], int inputlen)
{
    int i = 0;

    if (!result) {
        printf("You need a valid results array you dummy!\n");
        return;
    }

    for (i = 0; i < inputlen; ++i) {
        if (i < inputlen) {
            result[i] = array1[i];
        }

        result[i + inputlen] = array2[i];
    }

    return;
}


int main (void)
{
    int array1[] = {1, 2, 3};
    int array2[] = {4, 5, 6};
    int array3[6];
    
    concat_array(array3, 6, array1, array2, 3);

    int i = 0;
    for (i = 0; i < 6; ++i) {
        printf("%i ", array3[i]);
    }
    printf("\n");

    return 0;
}