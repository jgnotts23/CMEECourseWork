#include <stdio.h>
#include <stdlib.h>

int main (void)
{
    /* a pointer is just a type of data, a memory address */

    int age = 30;
    int * pAge = &age;  // Creates a pointer that stores the memory address of 'age'

    double gpa = 2.4;
    double * pGpa = &gpa; // Pointers also have their own memory addresses and can be pointed to themselves

    char grade = 'A';
    char * pGrade = &grade;


    printf("age's memory address: %p\n", &age); // &age is a pointer
    printf("age's memory address: %p\n", pAge); // exactly the same as above
    printf("pointer to age's memory address: %p\n", &pAge); // pointing to a pointer

    return 0;
}