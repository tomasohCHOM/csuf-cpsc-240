// Name:Tomas Oh
// Section: CPCS 240-03
// Email: tomasoh@csu.fullerton.edu
// Date: December 6, 2023


#include <stdio.h>

extern int manage_array();

int main() {
  printf("Welcome to Array Management System\n");
  printf("This product is maintained by Tomas Oh at tomasoh@csu.fullerton.edu\n\n");

  int size = manage_array();
  
  printf("The main function received %i and will keep it for a while.\n", size);
  printf("Please consider buying more software from our suite of commercial program.\n");
  printf("A zero will be returned to the operating system.  Bye\n");

  return 0;
}