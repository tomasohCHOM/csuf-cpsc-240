#!/bin/bash


#Author: Tomas Oh
#Program name: GDB Example 2

rm *.o
rm *.out

echo "This is program <GDB Example 2>"

echo "Compile the C++ module main.cpp"
g++ -c -m64 -Wall -o main.o main.cpp -fno-pie -no-pie -std=c++17 -g

echo "Link the object files already created"
g++ -m64 -o main.out main.o -fno-pie -no-pie -std=c++17 -g

echo "Run the program GDB Example 2"
gdb ./main.out

echo "The bash script file is now closing."
