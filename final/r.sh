
#!/bin/bash

#Author: Tomas Oh
#Program name: Final Programming

rm *.o
rm *.out

echo "This is program <Final Programming>"

echo "Compile the C module main.c"
gcc -c -m64 -Wall -o main.o main.c -fno-pie -no-pie -std=c17

echo "Assemble the module manage.asm"
nasm -f elf64 -l manage.lis -o manage.o manage.asm

echo "Assemble the module input_array.asm"
nasm -f elf64 -l input_array.lis -o input_array.o input_array.asm

echo "Assemble the module output_array.asm"
nasm -f elf64 -l output_array.lis -o output_array.o output_array.asm

echo "Link all the object files already created"
gcc -m64 -o arr.out main.o manage.o input_array.o output_array.o -fno-pie -no-pie -std=c17

echo "Run the program Final Programming"
./arr.out

echo "The bash script file is now closing."