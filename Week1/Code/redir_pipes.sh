#!/bin/bash
# Author: Jacob Griffiths jacob.griffiths18@imperial.ac.uk
# Script: redir_pipes.sh
# Desc: demonstrating redirection and pipes
# Date: Nov 2018

# Redirecting output to a file, if the file already exists it wil be overwritten
echo "My first line." > ../Results/test.txt
cat ../Results/test.txt

# Append the output to a file, if the file does not exist, it will be created.
echo "My second line" >> ../Results/test.txt
cat ../Results/test.txt

# Listing all files in directory and listing in a file
ls / >> ../Results/ListRootDir.txt
cat ../Results/ListRootDir.txt

# Commands can also be concatenated with pipes "|"
# How many files in root directory?
ls / | wc -l

# List files in long format and sorted by modification time, newest first
# Only print first 5 files
ls -lt | head -5

exit