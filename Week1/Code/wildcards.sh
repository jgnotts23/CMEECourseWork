#!/bin/bash
# Author: Jacob Griffiths jacob.griffiths18@imperial.ac.uk
# Script: wildcards.sh
# Desc: demonstrating wildcards
# Date: Nov 2018

# Wildcards can be used to find files based on their names
# First, make some test files
mkdir ../Sandbox/TestWild
cd ../Sandbox/TestWild
touch File1txt
touch File2.txt
touch File3.txt
touch File4.txt
touch File1.csv
touch File2.csv
touch File3.csv
touch File4.csv
touch Anotherfile.csv
touch Anotherfile.txt
ls 
ls | wc -l

# "?"	    Any single character, except a leading dot (hidden files).
# "*"	    Zero or more characters, except a leading dot (hidden files).
# "[A-Z]"	Define a class of characters (e.g., upper-case letters).

# Finding files
ls * # finds all except hidden files (leading dot)
ls File* # anything starting with "File"
ls *.txt # anything ending with ".txt"
ls File?.txt # anything starting with "File", followed by 1 character, and ending with ".txt"
ls File[1-2].txt # anything starting with "File", followed by 1 or 2, and ending with ".txt"
ls File[!3].* # anything starting with "File", followed by anything except 3, and any ending