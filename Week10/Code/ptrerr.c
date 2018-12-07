#include <stdio.h>
#include <stdlib.h>

int main (void)
{
    int a = 7;
    int *a_ptr = NULL;
    int **a_pptr = NULL;
    int result = 0;

    // Guard pointers against dereferencing NULL
    if (a_pptr != NULL) {
        result = **a_ptr;
    }

    return 0;
}