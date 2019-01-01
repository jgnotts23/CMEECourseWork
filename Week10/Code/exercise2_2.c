#include <stdio.h> //semicolon removed

int main (void)
{
     int x = 1;
     char a = 'a';
     float onepoint1 = 1.1; //previously 1point1, can't start variable with numeric in C
     
     printf("An integer: %i\n", x);
     printf("A character: %c\n", a); //semicolon added
     printf("A floating point: %f\n", onepoint1);
     
     return 0;
}