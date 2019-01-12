#include <stdio.h>
#include <stdlib.h>

double cube(double num) {
    double result = num * num * num;
    return result; //return BREAKS function and returns value
    // return num * num * num; would also give same result
}

int main (void)
{
    printf("Answer: %f\n", cube(3.0));

    return 0;
}