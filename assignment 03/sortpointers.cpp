// *****************************************************************************************************
//  Program name: "Sort by Pointers." This program demonstrates the input of
//  array values as pointers and the sorting of its elements (pointers) based
//  off its values (floating-point numbers). Copyright (C) 2023 Tomas Oh.
// 
//  "Sort by Pointers" is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
// 
//  "Sort by Pointers" is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
//  GNU General Public License for more details.
//  
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <https://www.gnu.org/licenses/>.
// *****************************************************************************************************

// ========1=========2=========3=========4=========5=========6=========7=========8=========9=========0**
// 
// Author information
//   Author name: Tomas Oh
//   Author email: tomasoh@csu.fullerton.edu
//   Author CWID: 885566877
//   Author NASM: NASM version 2.15.05
//   Author Operating System: Ubuntu 22.04
// 
// Program information
//   Program name: Sort by Pointers
//   Programming languages: Two modules in C++, one module in C and three modules in X86
//   Date program due: Oct-9-2023 (Baseline) Oct-16-2023 (Challenge)
//   Date program began: Oct-1-2023
//   Date of last update: Oct-9-2023
//   Date comments upgraded: Oct-9-2023
//   Date open source license added: Oct-5-2023
//   Files in this program: 
//    main.cpp director.asm inputarray.asm outputarray.c sortpointers.asm sortpointers.cpp
//   Status: Finished.
// 
// Purpose:
//   This program demonstrates creating a pointer array in which a user can input up to 10
//   numbers and the program will create an array of pointes that will point to those values.
//   The program will print those values into standard output and following that, it will start
//   sorting the elements in the array through the pointers rather than its values. Finally, it
//   will return the array to the C drier before finishing the program's execution.
// 
// This file
//   File name: sortpointers.cpp
//   Language: C++
//   Max page width: 132 columns
//   Compiled: g++ -c -m64 -Wall -o sortpointers.o sortpointers.cpp -fno-pie -no-pie -std=c++17
//   Purpose:
//      This C++ file contains the function sort_pointers, which takes in
//      an array and a size as parameters and sorts its elements in ascending
//      order. Rather than sorting based on the floating-point values, since
//      the array consists of double pointers, it will only move the pointers
//      themselves. The function is implemented using bubble sort with a time
//      complexity (worst-case scenario) of O(n^2) and space complexity of O(1).

// ===== Begin code area ===============================================================================


extern "C" void sort_pointers(double*[], unsigned long);

void sort_pointers(double *arr[], unsigned long size) {
    bool swapped;
    for (unsigned long i = 0; i < size; ++i) {
        swapped = false;
        for (unsigned long j = 0; j < size - i - 1; ++j) {
            if(*(arr[j]) > *(arr[j + 1])) {
                // Swap arr[j] and arr[j + 1]
                double *temp = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = temp;
                swapped = true;
            }
        }
        // If no two elements are swapped by inner loop, break
        if (!swapped) {
            break;
        }
    } 
}