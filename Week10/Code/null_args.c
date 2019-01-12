#include <stdio.h>

void double_array_values(long double fparray[], long long intarray[], int nelems)
{
    int i;
	
    if (fparray) {
        for (i = 0; i < nelems; ++i) {
	    fparray[i] = fparray[i] * 2;
	}
    }
    else if (intarray) {
	for (i = 0; i < nelems; ++i) {
	    intarray[i] = intarray[i] * 2;
	}
    }
}


int main (void)
{
    int nelems = 4;
    long long intarray[] = {81, 8, 4, 30};
    long double fparray[] = {2.30, 10.1, 10.0, 81.8};

    double_array_values(NULL, intarray, nelems);
    double_array_values(fparray, NULL, nelems);

    return 0;
}