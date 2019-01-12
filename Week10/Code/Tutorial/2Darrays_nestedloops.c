#include <stdio.h>
#include <stdlib.h>

int main (void)
{
    /* 2D arrays */
    int nums[3][2] = {       //Have to specify number of arrays then number of elements in each array
        {1, 2},
        {3, 4},
        {5, 6}
    };

    int i, j;       //can declare 2 things at once
    for(i = 0; i < 3; i++){
        for(j = 0; j < 2; j++){
            printf("%d,", nums[i][j]);
        }
        printf("\n");
    }

    return 0;
}