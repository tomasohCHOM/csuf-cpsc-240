#!/bin/bash


#Author: Tomas Oh
#Program name: Basic Float Operations

rm *.o
rm *.out

echo "This is program <Demonstrate Numeric IO>"

echo "Assemble the module main.asm"
nasm -f elf64 -l main.lis -o main.o main.asm -gdwarf

echo "Compile the C++ module main-driver.cpp"
g++ -c -m64 -Wall -o main-driver.o main-driver.cpp -fno-pie -no-pie -std=c++17 -g

echo "Link the two object files already created"
g++ -m64 -o main.out main-driver.o main.o -fno-pie -no-pie -std=c++17 -g

echo "Run the program Basic Float Operations"
gdb ./main.out

echo "The bash script file is now closing."
