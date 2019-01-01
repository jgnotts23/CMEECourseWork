#include <stdio.h>

int main (void)
{
    int i1 = 2;
    int f1 = 7;
    int intres = 0;
    float fres = 0;

    printf("Assign mixed to int:                %i\n", intres = f1/i1);
    printf("Assign mixed to float:              %f\n", fres = f1/i1);
    printf("Assign mixed with const to float:   %f\n", fres = f1/2);

    return 0;
}