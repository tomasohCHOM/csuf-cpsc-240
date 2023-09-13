#!/bin/bash


#Author: Tomas Oh
#Program name: Array Management System

rm *.o
rm *.out

echo "This is program <Assignment 2 - Array Management System>"

echo "Assemble the module manage.asm"
nasm -f elf64 -l main.lis -o manage.o manage.asm

echo "Compile the C++ module main-driver.c"
gcc -c -m64 -Wall -o main-driver.o main-driver.c -fno-pie -no-pie -std=c17

echo "Link the two object files already created"
gcc -m64 -o main.out main-driver.o manage.o -fno-pie -no-pie -std=c17

echo "Run the program Assignment 2 - Array Management System"
./main.out

echo "The bash script file is now closing."