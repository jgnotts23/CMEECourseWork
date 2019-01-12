#include <stdio.h>
#include <stdlib.h>

int main (void)
{
    int age;
    printf("Enter your age: \n");
    scanf("%d", &age); // & is a pointer here and scanf reads the user input
    printf("You are %d years old\n", age);

    char name[20];
    printf("Enter your name: \n");
    //scanf("%s", name); // scanf falls down here if the user uses a space, it will finish reading at that point
    fgets(name, 20, stdin); // Can use fgets instead, allows you to limit string length of USER too to prevent overflow
    printf("Your name is %s", name);

    return 0;
}