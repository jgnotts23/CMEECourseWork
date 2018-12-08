#include <stdio.h>
#include <stdlib.h>

typedef struct safe_intarray {
    int* intdata;
    int nelems;
} safe_intarray;

//void set_int_data(struct int* sarray, int index)
//{}

int get_int_data(safe_intarray* sarray, int index)
{
    int res = 0;
    if (index < (*sarray).nelems){
        //res = (*sarray).intdata[index];
        res = sarray->intdata[index];
    }
    else {
        printf("Error: subscript out of bounds\n");
    }

    return res;
}

int main (void)
{
    struct safe_intarray a1;

    int nelems = 10;

    a1.intdata = (int*)malloc(nelems * sizeof(int));
    a1.nelems = nelems;

    a1.intdata[1] = 2;
    printf("Attempt to read out of bounds: %i\n", get_int_data(&a1, 17));
    printf("Attempt to read within bounds: %i\n", get_int_data(&a1, 1));

    return 0;
}