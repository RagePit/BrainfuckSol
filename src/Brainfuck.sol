// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.6;

library Brainfuck {

    bytes1 private constant INC_PTR = ">";
    bytes1 private constant DEC_PTR = "<";
    bytes1 private constant INC_VALUE = "+";
    bytes1 private constant DEC_VALUE = "-";
    bytes1 private constant OUTPUT = ".";
    bytes1 private constant INPUT = ",";
    bytes1 private constant START_LOOP = "[";
    bytes1 private constant END_LOOP = "]";

    function run(bytes memory commands, bytes memory inputs) internal pure returns(bytes memory output) {
        uint8[] memory stack = new uint8[](1024);
        uint ptr = 0;           //Stack pointer
        uint inputPtr = 0;      //Current input pointer
        uint instrCounter = 0;  //Total instructions executed

        uint numCmds = commands.length;
        unchecked {
            for (uint cmdPtr = 0; cmdPtr < numCmds; cmdPtr++) {
                bytes1 command = commands[cmdPtr];
                
                //Stop execution after 1m instructions
                if (instrCounter++ > 1000000) break;

                if (command == INC_PTR) {
                    //Increment stack pointer
                    ptr++;
                } else if (command == DEC_PTR) {
                    //Decrement stack pointer
                    ptr--;
                } else if (command == INC_VALUE) {
                    //Increment value at stack pointer, manually overflow
                    if (stack[ptr] == 255) stack[ptr] = 0;
                    else stack[ptr]++;
                } else if (command == DEC_VALUE) {
                    //Decrement value at stack pointer, manually underflow
                    if (stack[ptr] == 0) stack[ptr] = 255;
                    else stack[ptr]--;
                } else if (command == OUTPUT) {
                    //Append value at stack pointer to output
                    output = bytes.concat(output, bytes1(stack[ptr]));
                } else if (command == INPUT) {
                    //Take next input byte from inputs
                    if (inputPtr >= inputs.length) stack[ptr] = 0;
                    else stack[ptr] = uint8(inputs[inputPtr++]);
                } else if (command == START_LOOP) {
                    //If value at stack pointer is 0, skip to matching close brace
                    //If value is not 0, enter loop
                    if (stack[ptr] == 0) {
                        uint j = 1;
                        while (j > 0) {
                            command = commands[++cmdPtr];
                            if (command == START_LOOP) j++;
                            else if (command == END_LOOP) j--;
                        }
                    }
                } else if (command == END_LOOP) {
                    //If stack pointer is not 0, move backwards to matching open brace
                    //If value is 0, exit the loop
                    if (stack[ptr] != 0) {
                        uint j = 1;
                        while (j > 0) {
                            command = commands[--cmdPtr];
                            if (command == START_LOOP) j--;
                            else if (command == END_LOOP) j++;
                        }
                    }
                }
                
            }
        }
    }
}
