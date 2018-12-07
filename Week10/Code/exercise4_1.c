#include <stdio.h>

int main (void)
{
    int i = 3;

    for (i = 3; i < 101; ++i) {
        int j = 2;
        for (j = 2; j < 51; ++j) {
            if (i % j == 0) {
                printf("%i is not prime!\n");
                break;
            }
            else {
                printf("%i is prime!\n");
            }
        }
    printf("\n");
    

    }   


    return 0;
}