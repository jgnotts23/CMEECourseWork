#include <stdio.h>
#include <string.h>

int main (void)
{
    char mystring[] = "racecar";
    int i = 0;
    int end = 0;
    int j = 0;

    end = strlen(mystring);
    char mynewstring[end];

    for (i=0; i < end+1; ++i){
        j = end - i;
        mynewstring[j] = mystring[i];
    }

    for(i = 0; i < end+1; ++i) {
        printf("%c", mynewstring[i]);
    }

    printf("\n");

    return 0;
}