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

    return 0; // Everything went OK, Return 0 to the OS
}

// "gcc" to compile code
// "./a.out" to run code