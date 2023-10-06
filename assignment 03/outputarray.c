// Program name: "Sort by Pointers." This program demonstrates the input of
// array values as pointers and the sorting of its elements (pointers) based
// off its values (floating-point numbers). Copyright (C) 2023 Tomas Oh.
//
// "Sort by Pointers" is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// "Sort by Pointers" is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
// 
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

// Author name: Tomas Oh
// Author email: tomasoh@csu.fullerton.edu
// C.W.I.D.: 885566877
// Section: CPSC 240-03
// For: Assignment 3 - Sort By Pointers
// Due Date: 10/09/2023
// Completion Date: 10/06/2023
// Updated Date: 10/06/2023
// Operating System: Ubuntu 22.04
// This file
//   File name: outputarray.c
//   Language: C
//   Purpose:
//      This C file contains the output_array function, which loops through
//      the provided array and prints its values to standard output. Dereferencing
//      is needed because we are provided with an array of double pointers.

#include <stdio.h>

extern void output_array(double *[], unsigned long);

// Prints the contents of the array by dereferencing the value pointed at
// each element of the array.
void output_array(double *arr[], unsigned long size) {
    for (unsigned long i = 0; i < size; ++i) {
      printf("%1.10lf\n", *(arr[i]));
    }
}