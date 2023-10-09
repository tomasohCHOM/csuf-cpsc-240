#!/bin/bash


#Author: Tomas Oh
#Program name: Sort by Pointers

rm *.o
rm *.out

echo "This is program <Assignment 3 - Sort by Pointers>"

echo "Compile the C++ module main.cpp"
g++ -c -m64 -Wall -o main.o main.cpp -fno-pie -no-pie -std=c++17

echo "Assemble the module director.asm"
nasm -f elf64 -l director.lis -o director.o director.asm

echo "Assemble the module inputarray.asm"
nasm -f elf64 -l inputarray.lis -o inputarray.o inputarray.asm

echo "Assemble the module outputarray.c"
gcc -c -m64 -Wall -o outputarray.o outputarray.c -fno-pie -no-pie -std=c17

echo "Compile the C++ module sortpointers.cpp"
g++ -c -m64 -Wall -o sortpointers.o sortpointers.cpp -fno-pie -no-pie -std=c++17

echo "Link all the object files already created"
g++ -m64 -o arr.out main.o director.o inputarray.o outputarray.o sortpointers.o -fno-pie -no-pie -std=c++17

echo "Run the program Assignment 3 - Sort by Pointers"
./arr.out

echo "The bash script file is now closing."