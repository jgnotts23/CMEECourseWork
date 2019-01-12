#include <stdio.h>

int main (void)
{
    int a = 0;
    int i = 0;
    while ( a == 0 ) {
        printf("i = %i\n", i);
        ++i; //infinite loop
    }
}