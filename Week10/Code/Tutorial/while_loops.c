#include <stdio.h>
#include <stdlib.h>

int main (void)
{
    int index = 6;
    while(index <= 5) {
        printf("%d\n", index);
        index++;
    }

    /* If you want the code to run first time without checking the condition then
    you can use a do-while loop */
    index = 6;
    do { 
        printf("%d\n", index);
        index ++;
    } while(index <=5);

    return 0;
}