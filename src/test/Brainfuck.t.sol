// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.6;

import "ds-test/test.sol";
import {Brainfuck} from "../Brainfuck.sol";

contract BrainfuckTest is DSTest {

    function test_EmptyProgram() public {
        bytes memory res = Brainfuck.run("", "");

        assertEq(string(res), "");
    }

    function test_HelloWorld() public {
        bytes memory res = Brainfuck.run("++++++++++[>+++++++>++++++++++>+++>++++<<<<-]>++.>+.+++++++..+++.>>++++.<++.<++++++++.--------.+++.------.--------.>+.", "");

        assertEq(string(res), "Hello, world!");
    }

    function test_AscendingNums() public {
        bytes memory res = Brainfuck.run("++++++++++>++++++++++++++++++++++++++++++++++++++++++++++++>++++++++++[>++++++++++++++++++++++++++++++++++++++++++++++++>++++++++++[<<<.>>.+<<<.>>>>-]<----------------------------------------------------------<<+>-]", "");
        
        assertEq(string(res), "00\n01\n02\n03\n04\n05\n06\n07\n08\n09\n10\n11\n12\n13\n14\n15\n16\n17\n18\n19\n20\n21\n22\n23\n24\n25\n26\n27\n28\n29\n30\n31\n32\n33\n34\n35\n36\n37\n38\n39\n40\n41\n42\n43\n44\n45\n46\n47\n48\n49\n50\n51\n52\n53\n54\n55\n56\n57\n58\n59\n60\n61\n62\n63\n64\n65\n66\n67\n68\n69\n70\n71\n72\n73\n74\n75\n76\n77\n78\n79\n80\n81\n82\n83\n84\n85\n86\n87\n88\n89\n90\n91\n92\n93\n94\n95\n96\n97\n98\n99\n");
    }

    function test_CalculateGoldenRatio() public {
        bytes memory res = Brainfuck.run("+>>>>>>>++>+>+>+>++<[+[--[++>>--]->--[+[+<+[-<<+]++<<[-[->-[>>-]++<[<<]++<<-]+<<]>>>>-<<<<<++<-<<++++++[<++++++++>-]<.---<[->.[-]+++++>]>[[-]>>]]+>>--]+<+[-<+<+]++>>]<<<<[[<<]>>[-[+++<<-]+>>-]++[<<]<<<<<+>]>[->>[[>>>[>>]+[-[->>+>>>>-[-[+++<<[-]]+>>-]++[<<]]+<<]<-]<]]>>>>>>>]", "");

        assertEq(string(res), "1.618033988749894848204586834365638117720309179805762");
    }

    function test_CalculateE() public {
        bytes memory res = Brainfuck.run(">>>>++>+>++>+>>++<+[[>[>>[>>>>]<<<<[[>>>>+<<<<-]<<<<]>>>>>>]+<]>->>--[+[+++<<<<--]++>>>>--]+[>>>>]<<<<[<<+<+<]<<[>>>>>>[[<<<<+>>>>-]>>>>]<<<<<<<<[<<<<]>>-[<<+>>-]+<<[->>>>[-[+>>>>-]-<<-[>>>>-]++>>+[-<<<<+]+>>>>]<<<<[<<<<]]>[-[<+>-]]+<[->>>>[-[+>>>>-]-<<<-[>>>>-]++>>>+[-<<<<+]+>>>>]<<<<[<<<<]]<<]>>>+[>>>>]-[+<<<<--]++[<<<<]>>>+[>-[>>[--[++>>+>>--]-<[-[-[+++<<<<-]+>>>>-]]++>+[-<<<<+]++>>+>>]<<[>[<-<<<]+<]>->>>]+>[>>>>]-[+<<<<--]++<[[>>>>]<<<<[-[+>[<->-]++<[[>-<-]++[<<<<]+>>+>>-]++<<<<-]>-[+[<+[<<<<]>]<+>]+<[->->>>[-]]+<<<<]]>[<<<<]>[-[-[+++++[>++++++++<-]>-.>>>-[<<<----.<]<[<<]>>[-]>->>+[[>>>>]+[-[->>>>+>>>>>>>>-[-[+++<<<<[-]]+>>>>-]++[<<<<]]+<<<<]>>>]+<+<<]>[-[->[--[++>>>>--]->[-[-[+++<<<<-]+>>>>-]]++<+[-<<<<+]++>>>>]<<<<[>[<<<<]+<]>->>]<]>>>>[--[++>>>>--]-<--[+++>>>>--]+>+[-<<<<+]++>>>>]<<<<<[<<<<]<]>[>+<<++<]<]>[+>[--[++>>>>--]->--[+++>>>>--]+<+[-<<<<+]++>>>>]<<<[<<<<]]>>]>]", "");

        assertEq(string(res), "2.718281828459045235360287");
    }

    function test_Input() public {
        bytes memory res = Brainfuck.run(",[.,]", "b5ffg");

        assertEq(string(res), "b5ffg");
    }

    function test_ReverseInput() public {
        bytes memory res = Brainfuck.run(">,[>,]<[.<]", "b5ffg");

        assertEq(string(res), "gff5b");
    }

    function test_BinaryCounter1() public {
        bytes memory res = Brainfuck.run("-[>[->]++[-<+]-]", "");

        assertEq(string(res), "");
    }

    function test_BinaryCounter2() public {
        bytes memory res = Brainfuck.run(">+[[>]+<[-<]>+]", "");

        assertEq(string(res), "");
    }

    function test_BubbleSort() public {
        bytes memory res = Brainfuck.run(">>,[>>,]<<[[<<]>>>>[<<[>+<<+>-]>>[>+<<<<[->]>[<]>>-]<<<[[-]>>[>+<-]>>[<<<+>>>-]]>>[[<+>-]>>]<]<<[>>+<<-]<<]>>>>[.>>]", "zbgft");

        assertEq(string(res), "bfgtz");
    }

    function test_BrainfuckInterpreter() public {
        bytes memory res = Brainfuck.run(
                ">>>+[[-]>>[-]++>+>+++++++[<++++>>++<-]++>>+>+>+++++[>++>++++++<<-]+>>>,<++[[>[->>]<[>>]<<-]<[<]<+>>[>]>[<+>-[[<+>-]>]<[[[-]<]++<-[<+++++++++>[<->-]>>]>>]]<<]<]<[[<]>[[>]>>[>>]+[<<]<[<]<+>>-]>[>]+[->>]<<<<[[<<]<[<]+<<[+>+<<-[>-->+<<-[>+<[>>+<<-]]]>[<+>-]<]++>>-->[>]>>[>>]]<<[>>+<[[<]<]>[[<<]<[<]+[-<+>>-[<<+>++>-[<->[<<+>>-]]]<[>+<-]>]>[>]>]>[>>]>>]<<[>>+>>+>>]<<[->>>>>>>>]<<[>.>>>>>>>]<<[>->>>>>]<<[>,>>>]<<[>+>]<<[+<<]<]", 
                ",[.,]!b5ffg"
            );

        assertEq(string(res), "b5ffg");
    }
}