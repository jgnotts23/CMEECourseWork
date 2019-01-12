#include <stdio.h>

int main (void) 
{
    char array1[] = "The quick brown fox ";
    char array2[] = "jumped over the lazy dog\n";
    char array3[45];
    int i = 0;
    int j = 0;

    for (i = 0; i < 21; ++i) {
        array3[i] = array1[i];
    }

    for (j = 0; j < 26; ++j) {
        array3[j+20] = array2[j];
    }

    for(i = 0; i < 46; ++i) {
        printf("%c", array3[i]);
        //printf("\n");
    }

    return 0;
}