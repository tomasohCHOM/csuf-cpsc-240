// Author name: Tomas Oh
// Author email: tomasoh@csu.fullerton.edu
// Operating System: Ubuntu 22.04
// For: Assignment 2 - Array Management System
// Purpose of this file:
//    This is the C driver that contains the start code and which calls the
//    assembly function manage_array from manage.asm.
// Completion Date: 09/18/2023
// Updated Date: 09/24/2023

#include "stdio.h"

// extern double manage_array();

extern double *manage_array(unsigned long *n);

int main() {
    printf("Welcome to Array Management System.\n");
    printf("This product is maintained by Tomas Oh at tomasoh@csu.fullerton.edu\n\n");
    // The following commented code belongs from the baseline assignment, in which it only
    // asked to return the sum of the array from Assembly. The challenge part asks to
    // return the array itself.

    // double return_code = -1.0;
    // return_code = manage_array();
    // printf("The main function received %1.10lf and will keep it for a while\n", return_code);

    unsigned long size = 0;
    double *arr = manage_array(&size);
    printf("The main function received this array\n");
    for (int i = 0; i < size; ++i) {
        printf("%1.10lf\n", arr[i]);
    }
    printf("Please consider buying more software from our suite of commercial program.\n");
    printf("A zero will be returned to the operating system. Bye.\n");
    return 0;
}