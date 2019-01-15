#include <stdio.h>
#include <stdlib.h>

int main (void)
{
    char line[255];
    FILE * freader = fopen("../../Results/employees.txt", "r"); // Reading an existing file

    fgets(line, 255, freader);  // Specify storage variable first, then max size, then pointer
    printf("%s", line);
    fgets(line, 255, freader);  // Now reads second line           
    printf("%s", line);

    printf("%s\n", *freader);

    fclose(freader);


    return 0;
}