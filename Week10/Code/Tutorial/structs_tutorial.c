#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Creating the struct:
struct Student {
    // Convention to use capital letter for struct name
    char name[50];
    char major[50];
    int age;
    double gpa;
}; //note semicolon here

int main (void)
{
    /* A struct is a data structure where you can store groups of datatypes */

    struct Student student1;  //Creates a container called student1 that can contain the data specified above
    student1.age = 22;
    student1.gpa = 3.2;
    strcpy( student1.name, "Jim"); //note the need for string copy function here
    strcpy( student1.major, "Business");

    struct Student student2; 
    student2.age = 20;
    student2.gpa = 2.5;
    strcpy( student2.name, "Pam");
    strcpy( student2.major, "Art");

    printf("%s\n", student2.name);

    return 0;
}