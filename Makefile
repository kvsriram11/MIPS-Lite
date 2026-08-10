# ============================================================================
# Makefile for the MIPS-lite simulator
# Builds every .c under src/ into one executable called mips-lite
# ============================================================================

CC      := gcc
CFLAGS  := -std=c11 -Wall -Wextra -Wpedantic -Werror -Iinclude -g -O0
LDFLAGS :=

# Find every .c file under src/ and turn it into a matching .o path
SRCS := $(wildcard src/*.c)
OBJS := $(SRCS:src/%.c=build/%.o)

TARGET := mips-lite

# Default target, runs when you type just `make`
all: $(TARGET)

# Link step: combine all .o files into the final executable
$(TARGET): $(OBJS)
	$(CC) $(LDFLAGS) -o $@ $^

# Compile step: turn each src/foo.c into build/foo.o
# The "| build" part means "make sure build/ exists first"
build/%.o: src/%.c | build
	$(CC) $(CFLAGS) -c -o $@ $<

# Create the build directory if it does not exist
build:
	mkdir -p build

# Remove everything we generated
clean:
	rm -rf build $(TARGET)

# These names are not real files, so always run them when asked
.PHONY: all clean