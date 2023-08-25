#!/bin/bash


#Author: Tomas Oh
#Program name: Basic Float Operations

rm *.o
rm *.out

echo "This is program <Demonstrate Numeric IO>"

echo "Assemble the module lasvegas.asm"
nasm -f elf64 -l lasvegas.lis -o lasvegas.o lasvegas.asm

echo "Compile the C++ module lasvegas-driver.cpp"
g++ -c -m64 -Wall -o lasvegas-driver.o lasvegas-driver.cpp -fno-pie -no-pie -std=c++17

echo "Link the two object files already created"
g++ -m64 -o lasvegas.out lasvegas-driver.o lasvegas.o -fno-pie -no-pie -std=c++17

echo "Run the program Basic Float Operations"
./lasvegas.out

echo "The bash script file is now closing."
