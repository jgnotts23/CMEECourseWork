#include <stdio.h>
#include <stdlib.h>

int main (void)
{
    int age = 30;
    int * pAge = &age; // storing memory address of 'age'

    printf("age: %d\n", age);
    printf("age's memory address: %p\n", pAge); // print memory address of 'age'
    printf("age's dereferenced memory address: %d\n", *pAge); // dereference pointer and print 'age' itself
    printf("age's dereferenced memory address: %d\n", *&age); //dereference the pointer in one go

    return 0;
}