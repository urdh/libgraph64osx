# Part of the libgraph64osx library. See LICENSE.md for licensing details.
CC=clang
CCFLAGS=-c -Wall -m64 -Os -O3 -O4 -ObjC
LDFLAGS=-dynamiclib -framework AppKit -framework Foundation
LIBRARY=libgraph64osx.dylib
SOURCES=$(wildcard *.m)
OBJECTS=$(SOURCES:.m=.o)

.PHONY: all clean

all: $(LIBRARY)

$(LIBRARY): $(OBJECTS)
	$(CC) $(LDFLAGS) $(OBJECTS) -o $@

.m.o:
	$(CC) $(CCFLAGS) $<

clean:
	-rm -rf $(OBJECTS) $(LIBRARY)
