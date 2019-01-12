#include <stdio.h>
#include <stdlib.h>

int main (void)
{
    int luckyNumbers[] = {4, 8, 15, 16, 23, 42};
    luckyNumbers[1] = 200; // modify array element
    printf("%d\n", luckyNumbers[1]); // print single array element

    return 0;
}