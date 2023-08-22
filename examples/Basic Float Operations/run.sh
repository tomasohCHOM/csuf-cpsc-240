#!/bin/bash


#Author: Floyd Holliday
#Program name: Basic Float Operations

rm *.o
rm *.out

echo "This is program <Demonstrate Numeric IO>"

echo "Assemble the module fp-io.asm"
nasm -f elf64 -l fp-io.lis -o fp-io.o fp-io.asm

echo "Compile the C++ module fp-io-driver.cpp"
g++ -c -m64 -Wall -o fp-io-driver.o fp-io-driver.cpp -fno-pie -no-pie -std=c++17

echo "Link the two object files already created"
g++ -m64 -o fpio.out fp-io-driver.o fp-io.o -fno-pie -no-pie -std=c++17

echo "Run the program Basic Float Operations"
./fpio.out

echo "The bash script file is now closing."
