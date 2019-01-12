#include <stdio.h>

int main()
{
    int number = 1; // the numbers to test
    int no_multiples = 0; //counter

    while (no_multiples < 34)
    {
        if (number % 7 == 0){
            if (number % 10 == 0){
                ++no_multiples; 
                printf("The number %i is a multiple of 7 and 10\n", number);
            }
            else {
                ++no_multiples;
                printf("The number %i is a multiple of 7\n", number);
            }
        }

        else if (number % 10 == 0) {
            ++no_multiples;
            printf("The number %i is a multiple of 10\n", number);
        }
        
        ++number; // increment number counter
    }

    return 0;
}