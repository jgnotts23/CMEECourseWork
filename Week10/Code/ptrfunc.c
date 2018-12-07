#include <stdio.h>

void index_through_array(int mynumbers[5], int* index)
{
    while (*index < 5) {
        printf("Element %i: %i\n", *index, mynumbers[*index]);
        ++(*index);  // Notice incrementing variable index that was passed in
    }

    printf("Value of index at end of function call: %i\n", *index);
    return; // Function has no return value
}

int* ptr_2_array(int* intarray, int index, int arraymax)
{
    int* result = NULL;

    if (index < arraymax) {
        result = &intarray[index];
    }

    return result;
}

int main (void)
{
    int index = 0;
    int mynums[] = {19, 81, 4, 8, 10};
    int* x_ptr;
    char c = '@';
    char* cptr = &c;
    void* anydata = NULL;

    x_ptr = &mynums[3];
    anydata = (void*)x_ptr;
    anydata = (void*)cptr;

    printf("Derefencing anydata: %c\n", *((char*)cptr));



    printf("Value of i before function call: %i\n", index);
    index_through_array(mynums, &index);  // Pass index to this function
    printf("Value of i after function call: %i\n", index);

    int *valptr;

    valptr = ptr_2_array(mynums, 1, 5);

    printf("Value in mynums at position %i: %i\n", 1, *valptr);

    return 0;
}