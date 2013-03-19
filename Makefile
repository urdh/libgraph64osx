.PHONY: all test

all: libgraph64.dylib
test: simple_graphics

libgraph64.dylib:
	clang -framework AppKit --shared -o libgraph64osx.dylib graph64osx.m

simple_graphics:
	clang -o simple_graphics -L. -lgraph64osx simple_graphics.c
