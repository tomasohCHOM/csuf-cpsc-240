// Name: Tomas Oh
// Section: CPSC 240-03
// CWID: 885566877
// Email: tomasoh@csu.fullerton.edu

#include "stdio.h"

extern double manage_array();

int main() {
    printf("\nWelcome to My Array by Tomas Oh.\n");
    double num = manage_array();
    printf("The main received this number: %lf and will study it.\n", num);
    printf("0 will be returned to the operating system.\n");
    return 0;
}