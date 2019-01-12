#include <stdio.h>
#include <stdlib.h>

int main (void)
{
    char grade = 'F';

    /* Switch statements useful for when you want to compare one value to
    several other values */

    switch(grade){
        case 'A' :  // means 'in the case of 'A''
            printf("You did great! \n");
            break;
        case 'B' : 
            printf("You did alright \n");
            break;
        case 'C' : 
            printf("You did poorly \n");
            break;
        case 'D' : 
            printf("You did very bad \n");
            break;
        case 'F' : 
            printf("You failed! \n");
            break;
        default : // Like an else statement
            printf("Invalid grade\n");
    }

    return 0;
}