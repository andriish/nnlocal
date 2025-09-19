#!/bin/bash

# Exit on error
set -e

# Run make with bear to generate compile_commands.json
bear -- make

# Check if compile_commands.json was created
if [ ! -f compile_commands.json ]; then
    echo "Error: compile_commands.json not found."
    exit 1
fi

# Extract and list all compiled source files
echo "Compiled source files:"
jq -r '.[].file' compile_commands.json | sort | uniq > make.txt



# Define source and build directories
SRC_DIR="."
BUILD_DIR="build"

# Configure the project with compile command export
cmake -S "$SRC_DIR" -B "$BUILD_DIR" -DCMAKE_EXPORT_COMPILE_COMMANDS=ON

# Run the build with bear to capture compilation database
bear -- cmake --build "$BUILD_DIR"

# Path to the compilation database
COMPILE_DB="$BUILD_DIR/compile_commands.json"

# Check if compile_commands.json exists
if [ ! -f "$COMPILE_DB" ]; then
    echo "Error: compile_commands.json not found in $BUILD_DIR"
    exit 1
fi

# List all compiled source files
echo "Compiled source files:"
jq -r '.[].file' "$COMPILE_DB" | sort | uniq > cmake.txt
