#!/bin/bash

# Check if the number of arguments is less than 2
if [ $# -lt 2 ]; then
  echo "Error: Missing arguments."
  echo "Usage: $0 <filesdir> <searchstr>"
  exit 1
fi
#arguments

filesdir="$1"
searchstr="$2"

# Check if filesdir is a directory
if [ ! -d "$filesdir" ]; then
  echo "Error: '$filesdir' is not a directory."
  exit 1
fi

# Count number of files under the directory (recursively)
num_files=$(find "$filesdir" -type f | wc -l)

# Count number of lines matching the search string
num_matches=$(grep -r "$searchstr" "$filesdir" 2>/dev/null | wc -l)

echo "The number of files are $num_files and the number of matching lines are $num_matches"

exit 0

