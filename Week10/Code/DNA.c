#include <stdio.h>
#include <stdlib.h>

int main (void)
{
    char sequence[] = "CATAAACCCTGGCGC";
    char sequence_2[] = "ATTCGTCGTTGGCTG";
    char base = 0;
    char base2 = 0;

    char A_ = (char)1;
    char C_ = (char)(1 << 1);
    char G_ = (char)(1 << 2);
    char T_ = (char)(1 << 3);

    printf("%i\n", C_);

    int i = 0;
    char bitsequence[15];
    char bitsequence_2[15];

    for (i=0; i<15; i++) {
        base = sequence[i];
        base2 = sequence_2[i];

        if (base == 'A' || base == 'a') {
            bitsequence[i] = A_;
        }
        else if (base == 'C' || base == 'c') {
            bitsequence[i] = C_;
        }
        else if (base == 'G' || base == 'G') {
            bitsequence[i] = G_;
        }
        else if (base == 'T' || base == 'T') {
            bitsequence[i] = T_;
        }
        else if (base == 'Y' || base == 'y') {
            bitsequence[i] = C_ | T_;
        }
        else if (base == 'R' || base == 'r') {
            bitsequence[i] = A_ | G_;
        }

        if (base2 == 'A' || base2 == 'a') {
            bitsequence_2[i] = A_;
        }
        else if (base2 == 'C' || base2 == 'c') {
            bitsequence_2[i] = C_;
        }
        else if (base2 == 'G' || base2 == 'G') {
            bitsequence_2[i] = G_;
        }
        else if (base2 == 'T' || base2 == 'T') {
            bitsequence_2[i] = T_;
        }
        else if (base2 == 'Y' || base2 == 'y') {
            bitsequence_2[i] = C_ | T_;
        }
        else if (base2 == 'R' || base2 == 'r') {
            bitsequence_2[i] = A_ | G_;
        }

        printf("%c, %i\n", base, bitsequence[i]);
        printf("%c, %i\n", base2, bitsequence_2[i]);

    
    }

    bitsequence & bitsequence_2;

    //printf("%i\n", bitsequence[0]);

    return 0;
}