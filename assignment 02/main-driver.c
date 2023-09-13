// Author name: Tomas Oh
// Author email: tomasoh@csu.fullerton.edu


#include "stdio.h"

extern double manage_array();

int main() {
  double return_code = -1.0;
  printf("Welcome to Array Management System.\n");
  printf("This product is maintained by Tomas Oh at tomasoh@csu.fullerton.edu\n");
  return_code = manage_array();
  printf("The main function received %lf and will keep it for a while\n", return_code);
  printf("Please consider buying more software from our suite of commercial program.\n");
  printf("A zero will be returned to the operating system. Bye.\n");
  return 0;
}