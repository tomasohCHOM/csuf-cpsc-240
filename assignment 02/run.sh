#!/bin/bash


#Author: Tomas Oh
#Program name: Array Management System

rm *.o
rm *.out

echo "This is program <Assignment 2 - Array Management System>"

echo "Compile the C module main-driver.c"
gcc -c -m64 -Wall -o main-driver.o main-driver.c -fno-pie -no-pie -std=c17

echo "Assemble the module manage.asm"
nasm -f elf64 -l manage.lis -o manage.o manage.asm

echo "Assemble the module input_array.asm"
nasm -f elf64 -l input_array.lis -o input_array.o input_array.asm

echo "Assemble the module output_array.asm"
nasm -f elf64 -l output_array.lis -o output_array.o output_array.asm

echo "Assemble the module sum_array.asm"
nasm -f elf64 -l sum_array.lis -o sum_array.o sum_array.asm

echo "Link all the object files already created"
gcc -m64 -o arr.out main-driver.o manage.o input_array.o output_array.o sum_array.o -fno-pie -no-pie -std=c17

echo "Run the program Assignment 2 - Array Management System"
./arr.out

echo "The bash script file is now closing."