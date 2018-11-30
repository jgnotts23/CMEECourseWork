#!/bin/bash
# Author: Jacob Griffiths jacob.griffiths18@imperial.ac.uk
# Script: grep.sh
# Desc: demonstrating grep
# Date: Nov 2018

# grep is a command that matches strings in a file (based on regex)

cd ../Sandbox
# Download test file
wget http://www.cep.unep.org/pubs/legislation/spawannxs.txt 

# Print first 50 lines
head -n 50 spawannxs.txt 

# Move file and change directory
mv spawannxs.txt ../Data/
cd ../Data

# Let's look for falcons
grep Falco spawannxs.txt

# Make it cast-insensitive
grep -i Falco spawannxs.txt

# Let's find the "Ara" macaws
grep -i ara spawannxs.txt # Returns some non-ara results

# Solve this by specifying only full word matches
grep -i -w ara spawannxs.txt

# Show line(s) after the one that was matched using -A x
grep -i -w -A 1 ara spawannxs.txt # shows 1 line after match

# -B shows lines before
grep -i -w -B 1 ara spawannxs.txt

# -n shows line number of match
grep -i -w -n ara spawannxs.txt

# -v prints all lines that DO NOT match pattern
grep -i -w -v ara spawannxs.txt