#!/bin/bash

# Check for two arguments
if [ $# -ne 2 ]; then
    echo "Error: Exactly two arguments required."
    echo "Usage: $0 <writefile> <writestr>"
    exit 1
fi

writefile="$1"
writestr="$2"

# Extract directory path
dirpath=$(dirname "$writefile")

# Create the directory path if it doesn't exist
mkdir -p "$dirpath"
if [ $? -ne 0 ]; then
    echo "Error: Failed to create directory path $dirpath"
    exit 1
fi

# Create or overwrite the file with the content
echo "$writestr" > "$writefile"
if [ $? -ne 0 ]; then
    echo "Error: Failed to write to file $writefile"
    exit 1
fi

# Exit with success
exit 0

