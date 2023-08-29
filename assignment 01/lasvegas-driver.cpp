// Name: Tomas Oh
// Completion Date: -/-/-

#include <stdio.h>
#include <iostream>

extern "C" double lasvegas();

int main() {
    std::cout << "\nWelcome to Trip Advisor by Tomas Oh.\n";
    std::cout << "We help you plan your trip.\n\n";
    // Call the lasvegas assembly prototype function
    double result = lasvegas();
    printf("%s%1.18lf%s", "The main module received this number ", result,
           " and will keep it for a while.\n");
    std::cout << "A zero will be sent to your operating system.\n";
    std::cout << "Good-bye. Have a great trip.\n";

    return 0;
}