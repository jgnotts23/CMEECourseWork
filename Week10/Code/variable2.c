#include <stdio.h>

// Can use global variables here but not advised

int main (void)
{
    float y = 2.03;
    int x = 1;
    float z = 0;

    z = x + y;

    /*  load y: 2.03
        load x: 1
        load r1
        move y to r1 (2.03)
        add x to r1 (3.03) TYPE PROMOTION, integer to float
        load z
        move r1 to z */


    printf("The value of z: %f\n", x);

    return 0;
}