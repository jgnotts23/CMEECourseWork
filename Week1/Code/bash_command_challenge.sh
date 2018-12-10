#!/bin/bash
# Author: Jacob Griffiths jacob.griffiths18@imperial.ac.uk
# Script: bash_command_challenge.sh
# Desc: A challenge question
# Date: Nov 2018

# What does this do?
find . -type f -exec ls -s {} \; | sort -n | head -10
# -type f, means the file is a regular file
# -exec ls -s {} \; is saying list all matches with their file size
# These results are then sorted by numerical string value
# Then the first 10 results are printed
# Essentially, it is finding and printing the 10 longest file names
exit