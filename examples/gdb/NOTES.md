# GDB (The GNU Project Debugger)

Tool to see what happens inside a program while it its being executed.

## Setup

To get started, modify the bash file used to compile, assemble and link your programs as follows:

- Compile C/C++ files with a `-g`
- Assemble with `-gdwarf`
- Run whatever output you get with `gdb ./main.out`

## Commands

|Command|Description                                                             |
|-------|------------------------------------------------------------------------|
|`b`    |Set up a breakpoint either by line number or by function name           |
|`r`    |Starts running the program                                              |
|`n`    |Executes the current instructions and shows the next instruction in line|
|`ni`   |Shows the next instruction without executing it                         |


|Format|Description                      |
|------|---------------------------------|
|`d`   |decimal, integer, 2's composition|
|`u`   |unsigned integer                 |
|`c`   |char                             |
|`a`   |address                          |
|`i`   |integer                          |
|`f`   |float (32 and 64 bits)           |
|`t`   |binary                           |
|`x`   |hex                              |

|Size |Description    |
|-----|---------------|
|`b`  |byte (1 byte)  |
|`h`  |half (2 bytes) |
|`w`  |word (4 bytes) |
|`g`  |giant (8 bytes)|

`p/` and `x/` output values to the terminal with format `x/<number of integers to output> <format> <size> <address to start at>`, e.g. `p/x $rsp`.