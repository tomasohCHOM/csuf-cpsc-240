//****************************************************************************************************************************
//Program name: "Basic Float Operations".  This program demonstrates the input and output of a float number and demonstrates *
//some basic math operations using float numbers.  Copyright (C) 2020 Floyd Holliday.                                        *
//                                                                                                                           *
//This file is part of the software program "Basic Float Operations".                                                        *
//Basic Float Operations is free software: you can redistribute it and/or modify it under the terms of the GNU General Public*
//License version 3 as published by the Free Software Foundation.                                                            *
//Basic Float Operations is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the       *
//implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more      *
//details.  A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                  *
//****************************************************************************************************************************
//
//Comment to students: notice how the Copyright Notice is separated from the License Notice.  The copyright part establishes
//you as the legal owner.  The license notice states what rights are conveyed to the recipient of this program.  The GPL3 
//conveys these basic rights: permission to study the source code, modify the source code, run it on any platform, distribute
//it in any media.   The GPL3 prohibits the recipient from removing the license from the source code and it prohibits
//information about the previous author(s).  There are more details about what GPL3 allows and disallows, but this is not
//the place to enumerate everything.  Visit the GNU website to know more details.
//
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//
//Author information
//  Author name: Floyd Holliday
//  Author email: holliday@fullerton.edu
//
//Program information
//  Program name: Basic Float Operations
//  Programming languages: One modules in C++ and one module in X86
//  Date program began: 2014-Aug-25
//  Date of last update: 2014-Sep-29
//  Date comments upgraded: 2020-July-04
//  Date open source license added: 2020-Sep-20
//  Date Basic Float Operations 2.0 released: 2020-November-6
//  Files in this program: fp-io-driver.cpp, fp-io.asm 
//  Status: Finished.
//  References consulted: Seyfarth, Chapter 11
//  Future upgrade possible: software to validate inputs and reject non-float inputs
//
//Purpose
//  This program will demonstrate how to input a single float number, multiply that inputted number by a floating point
//  constant and then output the results.
//
//This file
//  File name: fp-io-driver.cpp
//  Language: C++
//  Max page width: 132 columns  [132 column width may not be strictly adhered to.]
//  Compile this file: g++ -c -m64 -Wall -o fp-io-driver.o fp-io-driver.cpp -fno-pie -no-pie -std=c++17
//     [As the time of upgrade to this program C++ standard 2020 was not available.]
//  Link this program: g++ -m64 -o fpio.out fp-io-driver.o fp-io.o -fno-pie -no-pie -std=c++17

//===== Message to students ========================================================================================================

//This main function includes two header files, which both enable I/O functions in this same C++ function.

//===== Begin code area ============================================================================================================

#include <stdio.h>
//#include <stdint.h>    //Library not used
//#include <ctime>
//#include <cstring>
#include <iostream>
using namespace std;

extern "C" double floating_point_io();

int main(){

  double mystery_number = -0.00000000000000099;
  cout << "Welcome to Basic Float Operations" << endl;
  printf("The initial value of the mystery number is %1.16lf\n",mystery_number);
  mystery_number = floating_point_io();
  printf("%s%1.18lf%s\n","The driver received return code ",mystery_number,
         ".  The driver will now return 0 to the OS.  Bye.");
  cout << "The driver received code number " << mystery_number << " and will now return 0 to the OS." << endl;


  return 0;

}//End of main
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

