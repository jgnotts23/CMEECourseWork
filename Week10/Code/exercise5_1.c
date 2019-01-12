#include <stdio.h>

int main (void) 
{
    int i = 0;
    int myarray[] = {1, 2, 3, 4, 5};
    int isquared = 0;

    isquared = myarray[i] * myarray[i];

    printf("myarray[i] squared = %i\n", isquared);
    printf("The value at index %i in my array: %i\n", i, myarray[i]);
	
    return 0;
}