#!/bin/bash


#Author: Tomas Oh
#Program name: Assignment 4 - How to use strings

rm *.o
rm *.out

echo "This is program <Assignment 4 - How to use strings>"

echo "Assemble the module faraday.asm"
nasm -f elf64 -l faraday.lis -o faraday.o faraday.asm

echo "Compile the C module ampere.c"
gcc -c -m64 -Wall -o ampere.o ampere.c -fno-pie -no-pie -std=c17

echo "Link the two object files already created"
gcc -m64 -o program.out ampere.o faraday.o -fno-pie -no-pie -std=c17

echo "Run the program Assignment 4 - How to use strings"
./program.out

echo "The bash script file is now closing."
