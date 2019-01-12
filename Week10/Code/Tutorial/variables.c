#include <stdio.h>
#include <stdlib.h>

int main (void)
{
    char characterName[] = "Tom";
    int characterAge = 67;

    printf("There once was a man named %s\n", characterName);
    printf("he was %i years old.\n", characterAge);

    characterAge = 30; //Can change the value of a variable later on
    printf("He really liked the name %s\n", characterName);
    printf("But he did not like being %i.\n", characterAge);


    return 0;
}