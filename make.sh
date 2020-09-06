#!/usr/bin/env bash
#
mkdir out -p
ca65 src/main.asm -o out/hello.o --debug-info
ld65 out/hello.o -o out/hello.nes -C MMC3_128_128.cfg --dbgfile out/hello.dbg
