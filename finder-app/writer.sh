#!/bin/bash

# Check that exactly 2 arguments were provided
if [ $# -ne 2 ]; then
    echo "Error: Two arguments are required."
    echo "Usage: $0 <writefile> <writestr>"
    exit 1
fi

writefile="$1"
writestr="$2"

# Extract the directory path from the full file path
writedir=$(dirname "$writefile")

# Create the directory path if it does not exist
mkdir -p "$writedir"

# Write the string to the file, overwriting any existing content
echo "$writestr" > "$writefile"

# Check whether the file was created successfully
if [ $? -ne 0 ]; then
    echo "Error: Could not create file '$writefile'."
    exit 1
fi

exit 0