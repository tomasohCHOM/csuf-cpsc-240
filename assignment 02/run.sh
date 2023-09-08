#!/bin/bash


#Author: Tomas Oh
#Program name: Array Management System

rm *.o
rm *.out

echo "This is program <Assignment 2 - Array Management System>"

echo "Assemble the module main.asm"
nasm -f elf64 -l main.lis -o main.o main.asm

echo "Compile the C++ module main-driver.c"
g++ -c -m64 -Wall -o main-driver.o main-driver.c -fno-pie -no-pie -std=c++17

echo "Link the two object files already created"
g++ -m64 -o main.out main-driver.o main.o -fno-pie -no-pie -std=c++17

echo "Run the program Basic Float Operations"
./main.out

echo "The bash script file is now closing."