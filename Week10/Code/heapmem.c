#include <stdio.h>
#include <stdlib.h>

void print_intarray(int* array, int nelems)
{
    int i = 0;
    for (i = 0; i < nelems; ++i) {
        printf("%i ", array[i]);
    }
    printf("\n");
}

void destroy_intarray(int** intarray)
{
    if (*intarray) {
        free(*intarray);
        *intarray = NULL;
    }
}

int* make_intarray(int numelements)
{
    int* intarray = NULL;

    // void* malloc (size_t sizeofmem)
    //intarray = (int*)malloc(numelements * sizeof(int));
    // void* calloc (size_t nelems, size_t sizeofeach)
    intarray = (int*)calloc(numelements,  sizeof(int));
    if (intarray == NULL){
        printf("Error: unable to allocate sufficient memory at line: %i\n", __LINE__);
        exit(EXIT_FAILURE);
    }

    print_intarray(intarray, numelements);
    return intarray;
}

int main (void)
{
    int numsites = 10;
    int *sitedata = NULL; // Treat array of integer data

    sitedata = make_intarray(numsites);
    print_intarray(sitedata, numsites);
    destroy_intarray(&sitedata);
    destroy_intarray(&sitedata);
}