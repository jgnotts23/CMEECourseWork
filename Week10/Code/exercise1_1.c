#include <stdio.h> // preprocessor directive, standard C library

int main (void) // declare main arg and its type of return value, int
    // void is used as no arguments are passed into this particular function
{
    int myint = 4;
    // This is the main function for hello
    printf("Hello, world!\nI have initialised myint to %i.\n", myint); 
    /* semicolon to terminate a statement
     printf means print formatted 
     %i is an integer placeholder */

    return 2; // Everything went OK, Return 0 to the OS
}

/*  Q1 - removing '#include <stdio.h>' gives warnings about printf but still compiles and runs
    Q2 - removing 'return' seems to have no effect
    Q3 - changing the value of 'return' seems to have no effect */