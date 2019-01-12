#include <stdio.h>

int main (void)
{
    int i = 0;
    char mystring[] = "A string printed character-by-character\n";

    while(mystring[i]) {
        printf("%c", mystring[i]);
        ++i;
    }

    printf("\n");

    /* loop terminates when mystring[i] evaluates to 0.
    This is because strings have a hidden null 
    character: \0. This tells the compiler that the 
    string ends. The string thus contains n+1 elements
    where n is the number of characters and +1 is the 
    null character. Thus, the following two statements are 
    equivalent declarations: */

    char mystring1[] = "stringy!";
    char mystring2[] = {'s', 't', 'r', 'i', 'n', 'g', 'y', '!', '\0'};

    printf(mystring1);
    printf("\n");
    printf(mystring2);
    printf("\n");

    // Indexing strings
    i = 7;
    printf("Character %i in mystring1 is: %c\n", i, mystring1[i]);

    return 0;
}