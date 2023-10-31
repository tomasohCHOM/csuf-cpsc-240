#include <stdio.h>

extern double faraday();

int main() {
    printf("Welcome to Majestic Power Systems, LLC\n");
    printf("Project Director, Tomas Oh, Senior Software Engineer.\n\n");

    double result = faraday();

    printf("The main function received this number %lf and will keep it for future study.\n", result);
    printf("A zero will be returned to the operating system. Bye.\n");
    return 0;
}