// Program name: "Sort by Pointers." This program demonstrates the input of
// array values as pointers and the sorting of its elements (pointers) based
// off its values. Copyright (C) 2023 Tomas Oh
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
// Due Date: 10/09/2023
// Completion Date: -/-/2023
// Updated Date: -/-/2023
// Operating System: Ubuntu 22.04
// For: Assignment 3 - Sort By Pointers
// Purpose of this file:
//    This is the C driver that contains the start code and which calls the
//    assembly function director from director.asm.

extern "C" void sort_pointers(double*, unsigned long);

void sort_pointers(double *array, unsigned long size) {
    for (int i = 0; i < size; ++i) {
        for (int j = 0; i < size - i - 1; ++j) {
            if(*(current[j]) > *(current[j + 1])) {
                double temp = *(current[j]);
                *(current[j]) = *(current[j + 1]);
                *(current[j + 1]) = temp
            }
        }
    } 
}