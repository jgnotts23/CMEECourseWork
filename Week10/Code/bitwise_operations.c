#include <stdio.h>
#include <stdlib.h>

int main (void){
    int site1[] = {0, 0, 1, 1, 0, 1, 1, 1};
    int site2[] = {1, 1, 0, 1, 0, 0, 1, 1};

    int nspp = 8;
    int i = 0;

    for (i = 0; i < nspp; ++i) {
	    if (site1[i] == 1 && site2[i] == 1) {
            printf("%i and %i\n", site1[i], site2[i]);
		    //return 1;
	    }
    }

    for (i = 0; i < nspp; ++i) {
	    if (site1 & site2) {
            printf("%i and %i\n", site1[i], site2[i]);
		    return 1;
	    }
    }

    //printf("result = %i\n", result);

    return 0;
}