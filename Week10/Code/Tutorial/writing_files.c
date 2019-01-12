#include <stdio.h>
#include <stdlib.h>

int main (void)
{
    /* creating pointer to physical file on machine */
    FILE * fpointer = fopen("../Results/employees.txt", "w"); // Writes new file, overwrites if it already exists

    fprintf(fpointer, "Jim, Salesman\nPam, Receptionist\nOscar, Accounting\n"); // Data to be stored in file

    fclose(fpointer); // Close file


    FILE * fappend = fopen("../Results/employees.txt", "a"); // Create new pointer for appending

    fprintf(fappend, "Kelly, Customer Service\n"); // Line to be added

    fclose(fappend); // Close again

    return 0;
}