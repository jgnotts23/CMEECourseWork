#include <stdio.h>
#include <stdlib.h>

void sayHi (char name[], int age) { //specifying function arguments, void used because nothing is returned
    printf("Hello %s, you are %d\n", name, age);
}

int main (void)
{
    sayHi("Mike", 40); //calling function within main function

    return 0;
}