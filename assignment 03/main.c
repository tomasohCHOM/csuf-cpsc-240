// Author name: Tomas Oh
// Author email: tomasoh@csu.fullerton.edu
// C.W.I.D.: 885566877
// Due Date: 10/09/2023
// Completion Date: -/-/2023
// Updated Date: -/-/2023
// Operating System: Ubuntu 22.04
// For: Assignment 3 - Sort By Pointers
// Purpose of this file:
//    This is the C driver that contains the start code and which calls the
//    assembly function director from director.asm.

#include "stdio.h"

extern double *manage_array(unsigned long *n);

int main() {
    printf("Welcome to a great program developed by Tomas Oh.\n\n");
    unsigned long size = 0;
    double *arr = manage_array(&size);
    printf("The main function received this set of numbers:\n");
    for (int i = 0; i < size; ++i) {
        printf("%1.10lf\n", arr[i]);
    }
    printf("Main will keep these and send a zero to the operating system.\n");
    return 0;
}