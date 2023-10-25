#!/bin/bash


#Author: Tomas Oh
#Program name: Array with Left Rotate

rm *.o
rm *.out

echo "This is program <Midterm Programming - Array with Left Rotate>"

echo "Compile the C module welcome.c"
gcc -c -m64 -Wall -o welcome.o welcome.c -fno-pie -no-pie -std=c17

echo "Assemble the module manage.asm"
nasm -f elf64 -l manage.lis -o manage.o manage.asm

echo "Assemble the module input_array.asm"
nasm -f elf64 -l input_array.lis -o input_array.o input_array.asm

echo "Assemble the module output_array.asm"
nasm -f elf64 -l output_array.lis -o output_array.o output_array.asm

echo "Assemble the module sum_array.asm"
nasm -f elf64 -l sum_array.lis -o sum_array.o sum_array.asm

echo "Assemble the module rot_left.asm"
nasm -f elf64 -l rot_left.lis -o rot_left.o rot_left.asm

echo "Link all the object files already created"
gcc -m64 -o arr.out welcome.o manage.o input_array.o output_array.o sum_array.o rot_left.o -fno-pie -no-pie -std=c17

echo "Run the program Midterm Programming - Array with Left Rotate"
./arr.out

echo "The bash script file is now closing."