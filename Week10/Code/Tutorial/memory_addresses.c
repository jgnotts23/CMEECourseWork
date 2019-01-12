#include <stdio.h>
#include <stdlib.h>

int main (void)
{
    /* These variables will be stored in RAM during program execution
    C refers to the memory address of the variable when calling it */
    int age = 30;
    double gpa = 3.4;
    char grade = 'A';

    printf("age: %p\ngpa: %p\ngrade: %p\n", &age, &gpa, &grade); //accessing memory addresses of variables



    return 0;
}