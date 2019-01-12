#include <stdio.h>

int main (void)
{
    int myarray[] = {123, 747, 768, 2742, 988, 1121, 109, 999, 727, 1030, 999, 2014, 1402};
    int i = 0;
    int min = myarray[0];

    for (i = 1; i < 14; ++i) {
        if (myarray[i] < min) {
            min = myarray[i];
        }
    }

    printf("Minimum is: %i\n", min);

    return 0;
}