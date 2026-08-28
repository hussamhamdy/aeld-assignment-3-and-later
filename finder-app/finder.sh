#!/bin/bash

# Check that both required arguments were provided
if [ $# -ne 2 ]; then
    echo "Error: Two arguments are required."
    echo "Usage: $0 <filesdir> <searchstr>"
    exit 1
fi

filesdir="$1"
searchstr="$2"

# Check that filesdir is actually a directory
if [ ! -d "$filesdir" ]; then
    echo "Error: '$filesdir' is not a directory."
    exit 1
fi

# Count all regular files recursively
num_files=$(find "$filesdir" -type f | wc -l)

# Count all lines containing searchstr recursively
num_matching_lines=$(grep -r "$searchstr" "$filesdir" 2>/dev/null | wc -l)

echo "The number of files are $num_files and the number of matching lines are $num_matching_lines"