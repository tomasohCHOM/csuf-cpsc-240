#!/bin/bash


#Author: Tomas Oh
#Program name: Assignment 01 - Las Vegas

rm *.o
rm *.out

echo "This is program <Assignment 01 - Las Vegas>"

echo "Assemble the module lasvegas.asm"
nasm -f elf64 -l lasvegas.lis -o lasvegas.o lasvegas.asm

echo "Compile the C++ module lasvegas-driver.cpp"
g++ -c -m64 -Wall -o lasvegas-driver.o lasvegas-driver.cpp -fno-pie -no-pie -std=c++17

echo "Link the two object files already created"
g++ -m64 -o lasvegas.out lasvegas-driver.o lasvegas.o -fno-pie -no-pie -std=c++17

echo "Run the program Assignment 01 - Las Vegas"
./lasvegas.out

echo "The bash script file is now closing."
