#include <stdio.h>
#include <stdlib.h>

int main (void)
{
    int columns;
    int rows;

    for (rows = 1; rows <= 6; rows++) {

        for (columns = 1; columns <= 4; columns++) {
            printf("%d ", columns);
        }

        printf("\n");
    }

    return 0;
}